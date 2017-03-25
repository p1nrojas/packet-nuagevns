# Prepare your new bare metal server in packet.net

Create your baremetal server type 0 called "ansible".
Then run the following.

```
yum -y update
curl -fsSL https://git.io/vSkGs > install.sh; chmod 755 install.sh; ./install.sh
```

Create app container:
```
docker run -d -i -t --volumes-from vns-data-only --name vns-packet p1nrojas/packet-nuagevns # add /bin/bash to recreate
docker run -d -i -t --volumes-from vns-data-only --network weave --ip 192.168.0.100 --name vns-install p1nrojas/packet-nuagevns /bin/bash
```
...And play!
```
docker exec -i -t vns-packet /bin/bash
```
