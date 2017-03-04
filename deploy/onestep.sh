#!/bin/sh

server=139.196.235.210
sshUser=root
sshPort=18089
dir="ytx-app-service/"
appName="ytx-app-service"

env=$1
env=${env:-staging}

ssh -p $sshPort ${sshUser}@${server} "
  mkdir -p ${dir}
"

rsync -avzS --stats -e "ssh -p ${sshPort}"\
  --exclude .git\
  --exclude .vscode\
  --exclude node_modules\
  --exclude .tmp\
  --exclude typings\
  --exclude=**/*log* ./ ${sshUser}@${server}:~/${dir}

echo "server:${server} user:${sshUser}  port:${sshPort}  env:${env}"
ssh -p $sshPort ${sshUser}@${server} "
  cd ~/${dir}
  pwd
  pm2 stop $appName
  cnpm install --production
  pm2 start process.json --env $env
"