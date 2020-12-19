#!/bin/bash
cd /root/blog/source; while true; do git fetch --all -q && git reset --hard origin/master -q && git pull -q && sleep 20; done

