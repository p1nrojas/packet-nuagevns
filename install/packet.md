# Prepare your brand new bare metal server in packet.net

```
yum -y install docker
service docker start
yum -y install git
mkdir ~/docker
cd ~/docker
mkdir -p ./var/log
mkdir -p ./var/tmp
mkdir ~/docker/.ssh
ssh-keygen -t rsa -b 4096 -C "dev@nuage.io" -f ~/docker/.ssh/id_rsa -q -N ""
mkdir -p ~/docker/code
cd ~/docker/code
git clone https://github.com/p1nrojas/packet-nuagevns ~/docker/code/packet-nuagevns
echo "log_path = /var/log/ansible/ansible-vsc-in-a-box.log" >> ~/docker/code/packet-nuagevns/ansible.cfg
chown -R 1000:1000 ~/docker
cd ~/docker/code/packet-nuagevns/install
docker build -t packet-nuagevns .
docker run -d -i -t --name vns01 -v ~/docker/.ssh:/home/dev/.ssh -v ~/docker/var/log:/var/log/ansible -v ~/docker/code/packet-nuagevns:/home/dev/packet-nuagevns -v ~/docker/var/tmp:/tmp packet-nuagevns  /bin/bash
docker exec -i -t vns01 /bin/bash
```
