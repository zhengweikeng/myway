#!/bin/sh

# 跳板机server
jumpServer=116.62.5.21
# 跳板机User
jumpUser=pbuser
# 跳板机port
jumpPort=18089

# 压缩文件名
zipFilename=ytxappservice.tar.gz
# 文件上传到跳板机的指定路径
jumpPath="~/${zipFilename}"

# 删除本地旧的
rm -rf ${zipFilename}

# 压缩代码
tar --exclude=node_modules/\
  --exclude .DS_Store\
  --exclude .git\
  --exclude .vscode\
  --exclude .tmp\
  --exclude typings\
  --exclude=**/*log* -zcvf ${zipFilename} *

# 删除跳板机的压缩文件
ssh -p $jumpPort ${jumpUser}@${jumpServer} "
  rm -rf ~/${zipFilename}
"

# 将压缩文件上传到跳板机
scp -P $jumpPort $zipFilename ${jumpUser}@${jumpServer}:${jumpPath}
scp -P $jumpPort ./scripts/prod_start.sh ${jumpUser}@${jumpServer}:~/prod_start.sh

# 进入跳板机
action=$1
action=${action:-reload}
ssh -p $jumpPort ${jumpUser}@${jumpServer} "
  bash ~/prod_start.sh $action
  rm ~/prod_start.sh
"