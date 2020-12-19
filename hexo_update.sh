#!/bin/bash
head=""
while true
do 
  tmp=`git --git-dir="/root/blog/source/.git" log --pretty=format:"%h" -1`
  if [ "$head" != "$tmp" ] ;then
    hexo --cwd /root/blog clean && hexo --cwd /root/blog generate 
    cat /root/hexo.pid | xargs -I '{}' kill -9 {}
    hexo --cwd /root/blog server -p 80 & 
    echo "$!" > /root/hexo.pid
    head="$tmp"
  fi
  sleep 20
done 
