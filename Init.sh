#!/bin/bash

echo "The script only can be used on Ubuntu 18.04.4LTS"
echo "So, make sure your OS is it"
echo "Here are your OS version:"

sudo lsb_release -a

echo "Input 1 to continue, 0 to exit"

read -r is_version_wrong


if [ "$is_version_wrong" == 0 ]
then
  exit
fi

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

echo "" > /etc/apt/sources.list

cat > /etc/apt/sources.list <<EOF
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
EOF

sudo apt update
sudo apt upgrade -y

echo "Is there something wrong:"
echo "Input 1 to continue, 0 to exit"

read -r nothing_wrong

if [ "$nothing_wrong" == 0 ]
then
  exit
fi

sudo apt install  language-pack-zh-han* -y
sudo locale-gen zh_CN.GB18030
sudo locale-gen zh_CN.UTF-8
# 中文字体，别忘了同意 EULA
sudo apt install fontconfig -y
sudo apt install ttf-mscorefonts-installer -y
# 下面的再执行一遍以防万一
sudo apt install -y --force-yes --no-install-recommends fonts-wqy-microhei
sudo apt install -y --force-yes --no-install-recommends ttf-wqy-zenhei
sudo dpkg-reconfigure locales

sudo apt install manpages-zh
sudo sed -i 's/"/usr/share/man"/"/usr/share/man/zh_CN"/g' /etc/manpath.config

sudo apt install build-essential vim ddd gdb fpc emacs gedit anjuta lazarus -y
wget http://download.noi.cn/T/noi/GUIDE-1.0.2-ubuntu.tar
tar -xvf GUIDE-1.0.2-ubuntu.tar
cd GUIDE-1.0.2-ubuntu
chmod +x install.sh && ./install.sh

echo "Okay! Everything was done!"

echo "Input 0 to exit"

read -r now_exit

if [ "$now_exit" == 0 ]
then
  exit
fi
