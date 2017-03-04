# 部署
### [直接一步部署](./onestep.sh)

### 需要先部署到跳板机，再部署到生产机的[两步部署](./twostep.sh)

有时无法直接访问访问上产数据库，若有一台跳板机能够访问，可以将生产数据库的端口映射到跳板机，再从跳板机映射到本地

```makefile
mysql:
	ssh -p 18089 -nNT -L 3306:rm-bp1di17gtx669t1l5.mysql.rds.aliyuncs.com:3306 pbuser@116.62.5.21

redis:
	ssh -p 18089 -nNT -L 6379:r-bp11586fc4300144.redis.rds.aliyuncs.com:6379 pbuser@116.62.5.21	
```