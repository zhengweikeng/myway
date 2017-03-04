#!/bin/sh

# 压缩文件名
zipFilename=ytxappservice.tar.gz
prodServers=(s5)
# pm2 在生产机的路径
pm2="/home/pbuser/.nvm/versions/node/v6.9.1/bin/pm2"
npm="/home/pbuser/.nvm/versions/node/v6.9.1/bin/npm"

#获取参数 start/reload
action=$1

for prodServer in $prodServers
do
  ssh $prodServer "
    rm ~/${zipFilename}
  "

  scp ./${zipFilename} $prodServer:~/${zipFilename}
  ssh $prodServer "
    mkdir -p ytx-app-service
    tar -xvzf ${zipFilename} -C ytx-app-service

    source ~/.bash_profile
    cd ytx-app-service
    cnpm install --production

    if [[ $action = 'start' ]]; then
      pm2 start process.json --env production
    else
      pm2 reload process.json --env production
    fi
  "
done
