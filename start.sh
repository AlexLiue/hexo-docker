#!/bin/bash
export LC_ALL=C
service ssh start
sh /root/source_update.sh &
sh /root/hexo_update.sh &
tail -f /dev/null

