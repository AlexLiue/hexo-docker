#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
export LC_ALL=C
echo "export LC_ALL=C">> /etc/profile
sed -i "s+http://archive.ubuntu.com/ubuntu/+http://cn.archive.ubuntu.com/ubuntu/+g" /etc/apt/sources.list
apt-get update
apt-get -y install vim
apt-get -y install apt-utils
apt-get -y install language-pack-zh-hans
apt-get update
apt install -y curl
curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs
apt-get install -y git
npm install -g hexo-cli
apt-get install -y openssh-server
ssh-keygen -f /root/.ssh/id_rsa -N ""
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config
service ssh restart
mkdir /root/repo
git init --bare /root/repo
hexo init /root/blog
mv /root/blog/source /root/blog/source_bak
service ssh start
git clone ssh://root@localhost:/root/repo /root/blog/source
git --git-dir="/root/blog/source/.git" config --global user.email 'hexo@pcliu.com'
git --git-dir="/root/blog/source/.git" config --global user.name 'hexo'
cp -rf /root/blog/source_bak/_posts /root/blog/source/ && rm -rf /root/blog/source_bak
cd /root/blog/source && git add . && git commit -m "init" && git push origin master
sed -i 's+StrictHostKeyChecking no+StrictHostKeyChecking ask+g' /etc/ssh/ssh_config
apt-get clean
cd /root/blog && npm install hexo-theme-next@latest
mv /root/avatar.jpg /root/blog/node_modules/hexo-theme-next/source/images/
sed -i "s/title: Hexo/title: LiuPengCheng/g" /root/blog/_config.yml
sed -i "s/description: ''/description: '我自横刀向天笑，笑完我就去睡觉'/g" /root/blog/_config.yml
sed -i "s/author: John Doe/author: Liu PengCheng/g" /root/blog/_config.yml
sed -i "s/language: en/language: zh-CN/g" /root/blog/_config.yml
sed -i "s+timezone: ''+timezone: 'Asia/Shanghai'+g" /root/blog/_config.yml
sed -i "s+url: http://example.com+url: http://pcliu.site/blog+g" /root/blog/_config.yml
sed -i "s+root: /+root: /blog/+g" /root/blog/_config.yml
sed -i "s+theme: landscape+theme: next+g" /root/blog/_config.yml
sed -i "s+minify: false+minify: true+g" /root/blog/node_modules/hexo-theme-next/_config.yml
sed -i "s+scheme: Muse+#scheme: Muse+g" /root/blog/node_modules/hexo-theme-next/_config.yml
sed -i "s+#scheme: Gemini+scheme: Gemini+g" /root/blog/node_modules/hexo-theme-next/_config.yml
sed -i "s+#home:+home:+g" /root/blog/node_modules/hexo-theme-next/_config.yml
sed -i "s+#GitHub: https://github.com/yourname+GitHub: https://github.com/AlexLiue+g" /root/blog/node_modules/hexo-theme-next/_config.yml

sed -i "s+#about:+about:+g" /root/blog/node_modules/hexo-theme-next/_config.yml
mkdir /root/blog/source/about && echo "" >>/root/blog/source/about/index.md

sed -i "s+#tags:+tags:+g" /root/blog/node_modules/hexo-theme-next/_config.yml
mkdir /root/blog/source/tags
echo "---\ntitle: 标签\ndate: 2019-06-01 00:00:00\ntype: tags\n---\n" >/root/blog/source/tags/index.md

sed -i "s+#categories:+categories:+g" /root/blog/node_modules/hexo-theme-next/_config.yml
mkdir /root/blog/source/categories
echo "---\ntitle: 分类\ndate: 2019-06-01 00:00:00\ntype: categories\n---\n" > /root/blog/source/categories/index.md

sed -i "s+#archives:+archives:+g" /root/blog/node_modules/hexo-theme-next/_config.yml
mkdir /root/blog/source/archives
echo "---\ntitle: 归档\ndate: 2019-06-01 00:00:00\ntype: archives\n---\n" > /root/blog/source/archives/index.md

sed -i "s+#schedule:+schedule:+g" /root/blog/node_modules/hexo-theme-next/_config.yml
mkdir /root/blog/source/schedule
echo "">/root/blog/source/schedule/index.md

cd /root/blog/source && git add . && git commit -m "init" && git push origin master

sed -i "s+url: #/images/avatar.gif+url: /images/avatar.jpg+g" /root/blog/node_modules/hexo-theme-next/_config.yml

sed -i "$(($(sed -n '/changyan:/=' /root/blog/node_modules/hexo-theme-next/_config.yml) + 1))s/enable: false/enable: true/" /root/blog/node_modules/hexo-theme-next/_config.yml
sed -i "$(($(sed -n '/changyan:/=' /root/blog/node_modules/hexo-theme-next/_config.yml) + 2))s/appid:/appid: cyv86A5Xc/" /root/blog/node_modules/hexo-theme-next/_config.yml
sed -i "$(($(sed -n '/changyan:/=' /root/blog/node_modules/hexo-theme-next/_config.yml) + 3))s/appkey:/appkey: 14354a02d918bad680393da6e279dd55/" /root/blog/node_modules/hexo-theme-next/_config.yml

cd /root/blog && npm install npm install hexo-generator-searchdb
sed -i "$(($(sed -n '/local_search:/=' /root/blog/node_modules/hexo-theme-next/_config.yml) + 1))s/enable: false/enable: true/" /root/blog/node_modules/hexo-theme-next/_config.yml
sed -i '/# Extensions/a\# https://theme-next.js.org/docs/third-party-services/search-services\nsearch:\n  path: search.xml\n  field: post\n  content: true\n  format: html\n' /root/blog/_config.yml

