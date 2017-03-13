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
git clone https://github.com/p1nrojas/nuage-vns-inabox ~/docker/code/nuage-vns-inabox
echo "log_path = /var/log/ansible/ansible-vsc-in-a-box.log" >> ~/docker/code/nuage-vns-inabox/ansible.cfg
chown -R 1000:1000 ~/docker
cd ~/docker/nuage-vns-inabox/install
docker build -t nuage-vns-inabox .
docker run -d -i -t --name vns01 -v ~/docker/.ssh:/home/dev/.ssh -v ~/docker/var/log:/var/log/ansible -v ~/docker/code/nuage-vns-inabox:/home/dev/nuage-vns-inabox -v ~/docker/var/tmp:/tmp nuage-vns-inabox  /bin/bash
docker exec -i -t vns01 /bin/bash
```
