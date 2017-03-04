# 日志轮询
日志轮询使用pm2模块[pm2-logrotate](https://github.com/pm2-hive/pm2-logrotate)

测试环境配置
```shell
# log file max size: 1MB
pm2 set pm2-logrotate:max_size 100M
pm2 set pm2-logrotate:retain 5
pm2 set pm2-logrotate:rotateInterval '0 0 0 1 * *'
```

生产环境配置
```shell
# 待配置
pm2 set pm2-logrotate:max_size 100M
pm2 set pm2-logrotate:retain 30
pm2 set pm2-logrotate:rotateInterval '0 0 3 * * *'
```