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
weave launch --ipalloc-range 192.168.0.0/24
ip a add 192.168.0.1/24 dev weave
```

After reboot do as follow. 

```
mkdir -p ~/github/packet-nuagevns
cd ~/github/packet-nuagevns
curl -o Dockerfile https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/Dockerfile
curl -o vimrc https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/vimrc
curl -o bash_profile https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/bash_profile
curl -o setup.sh https://raw.githubusercontent.com/p1nrojas/packet-nuagevns/master/install/setup.sh
docker build -t p1nrojas/packet-nuagevns .
```

Create data-only and app container:

```
docker run -d --name vns-data-only p1nrojas/packet-nuagevns true
docker run -d -i -t --volumes-from vns-data-only --name vns-inabox p1nrojas/packet-nuagevns # add /bin/bash to recreate
```
...And play!
```
docker exec -i -t vns-inabox /bin/bash
```
