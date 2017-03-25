#!/bin/sh

#Install docker
echo "$(date) Installing Nuage VSP at packet.net (git.hub/p1nrojas)" > /tmp/install.log
echo "$(date) Installing dockers..."
curl -fsSL https://get.docker.com/ | sh >> /tmp/install.log
systemctl start docker >> /tmp/install.log
systemctl enable docker >> /tmp/install.log

#Install weave
echo "$(date) Installing weave..."
curl -L git.io/weave -o /usr/local/bin/weave >> /tmp/install.log
chmod a+x /usr/local/bin/weave >> /tmp/install.log
weave launch --ipalloc-range 192.168.0.0/24 >> /tmp/install.log
ip a add 192.168.0.1/24 dev weave >> /tmp/install.log

#Create container images
echo "$(date) Creating containers..."
mkdir -p ~/github/packet-nuagevns >> /tmp/install.log
cd ~/github/packet-nuagevns >> /tmp/install.log
curl -o Dockerfile https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/Dockerfile >> /tmp/install.log
curl -o vimrc https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/vimrc >> /tmp/install.log
curl -o bash_profile https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/bash_profile >> /tmp/install.log
curl -o setup.sh https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/setup.sh >> /tmp/install.log
docker build -t p1nrojas/packet-nuagevns . >> /tmp/install.log

#Create data-only container
echo "$(date) Creating data-only container..."
docker run -d --name vns-data-only p1nrojas/packet-nuagevns true >> /tmp/install.log
echo "$(date) done!"
