#!/bin/sh

#Install docker
echo "$(date) Installing dockers..."
curl -fsSL https://get.docker.com/ | sh
systemctl start docker
systemctl enable docker

#Install weave
echo "$(date) Installing weave..."
curl -L git.io/weave -o /usr/local/bin/weave
chmod a+x /usr/local/bin/weave
weave launch --ipalloc-range 192.168.0.0/24
ip a add 192.168.0.1/24 dev weave

#Create container images
echo "$(date) Creating containers..."
mkdir -p ~/github/packet-nuagevns
cd ~/github/packet-nuagevns
curl -o Dockerfile https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/Dockerfile
curl -o vimrc https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/vimrc
curl -o bash_profile https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/bash_profile
curl -o setup.sh https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/setup.sh
docker build -t p1nrojas/packet-nuagevns .

#Create data-only container
echo "$(date) Creating data-only container..."
docker run -d --name vns-data-only p1nrojas/packet-nuagevns true
echo "$(date) done!"
