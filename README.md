# Hexo Docker

## RUN  
```
docker run --restart=always -itd -p 10022:22 -p 80:80 --name hexo hexo:v1
```
## Port
10022: host ssh port  
80: web porta 

## Git Source
```
# copy local ~/.ssh/id_rsa.pub to remote 192.168.100.10 git server 
git clone ssh://root@192.168.100.10:10022/root/repo source
```
