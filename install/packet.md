# Prepare your new bare metal server in packet.net

Create your baremetal server type 0 called "ansible".
Then run the following.
Caution: This will reboot the server

```
yum -y update
curl -fsSL https://get.docker.com/ | sh
systemctl start docker
systemctl enable docker
curl -L git.io/weave -o /usr/local/bin/weave
chmod a+x /usr/local/bin/weave
reboot
ip a add 192.168.0.1/24 dev weave
```

After reboot do as follow. 

```
mkdir -p ~/github/packet-nuagevns
cd ~/github/packet-nuagevns
curl -o Dockerfile https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/Dockerfile
docker build -t packet-nuagevns .
```

When the docker image is finished, do as follow

```
docker run -d -i -t --name vns01 -v ~/packet-nuagevns/home:/home/dev -v ~/packet-nuagevns/var:/var -v ~/packet-nuagevnsvar/tmp:/tmp packet-nuagevns  /bin/bash
docker exec -i -t vns01 /bin/bash
```

Then, when to get into the container. run the following:

```
ssh-keygen -t rsa -b 4096 -C "dev@nuage.io" -f ~/.ssh/id_rsa -q -N ""
git clone //github.com/ansible/ansible ~/ansible
git clone https://github.com/p1nrojas/packet-nuagevns ~/packet-nuagevns
touch /var/log/ansible/ansible-packet-nuagevns.log
```
