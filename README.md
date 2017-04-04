## Caution! Use it under your own risk. Intended for PoCs and Labs

# Createyour SD-WAN experience at packet.net (Nuage Virtualized Network Services)

This playbook will create a Bare Metal Type 2 server at packet.net and install a whole Nuage VNS solution to try things like Zero Touch Bootstrapping and  Application Aware Routing.

Installing gateways, dns and ntp services, management and control planes in just one server with Centos7 KVM:
- Install your KVM server (sdwan01) into the brand new bare metal type 2 server.
- Create a dns/ntp/dhcp instance.
- Nuage VSD ( management ) and a couple of VCSs (control).
- Util server to bootstrap your NSGs
- Stat to collect stats and apply Intelligence
- Two NSG-vs as head ends at the Datacenter
- Two independent NSG-vs as remote sites and a couple of clients behind
- Clients are using Ubuntu Desktop
- WebVirtMgr to manage your instances and bootstrapping process

More details at pinrojas.com (http://wp.me/p44sHI-1iO) and Check the app at https://github.com/p1nrojas/packet-nuagevns
Check youtube at https://www.youtube.com/watch?v=ydQmYJQnkuo
More details about AAR at https://www.youtube.com/watch?v=bBdHYoLJ6Tk
And about Zero touch Bootstrapping (ZTP) at https://www.youtube.com/watch?v=nZUY4nq0Mmc

## Prepare your enviroment

Create a Bare Metal Tyoe 0 server called 'ansible' in your Project. You must have your Token ID, Project ID and Nuage License key at your reach.

## How to start

Create your baremetal server type 0 called "ansible" as I told you.
Then run the following.

```
yum -y update
curl -fsSL https://git.io/vSkGs > install.sh; chmod 755 install.sh; ./install.sh
```
This script will do everything. When you're done. Just add the KVM server to you WebVirtMgr and play. Let's figure your sdwan01 is using 10.88.157.133 as Public IP address. Then you have to do the follwoing to start playing. 
- Create libvirt user: saslpasswd2 -a libvirt virtmgr (use the password you want)
- Connect WebVirtMgr at: http://10.88.157.133:8090
- Use credentials (webvirtmgr): admin/webvirtmgr (don't forget to change password later)
- Connect VSD at: https://10.88.157.133:8443
- Clients (Ubuntu Desktop) use nuage/nuage credentials 

## Create app container
You can laso take a look to the playbook at ansible server creating a container as the following:

```
docker run -d -i -t --volumes-from vns-data-only --network weave --ip 192.168.0.100 --name vns-install p1nrojas/packet-nuagevns /bin/bash
docker exec -i -t vns-install /bin/bash
```

## Create your organization, NSG profiles....
There is an 'extras' folder inside packet-nuagevns folder (playbook directory) that you can use to set up your test domains:
```
cd extras
python vsd_script.py
```

See ya!
