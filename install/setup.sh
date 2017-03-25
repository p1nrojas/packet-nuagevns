#!/bin/bash

if [ ! -f /var/log/ansible/ansible-packet-nuagevns.log ]; then
    echo "There is not data. Proceed setup"
    git clone https://github.com/p1nrojas/packet-nuagevns ~/packet-nuagevns
    touch /var/log/ansible/ansible-packet-nuagevns.log
    ssh-keygen -t rsa -b 4096 -C "dev@nuage.io" -f ~/.ssh/id_rsa -q -N ""
    cd /home/dev/packet-nuagevns
    ansible-playbook build.yml
    /bin/bash
else
    echo "Caution: user data detected. skipping setup. Next time override CMD"
    /bin/bash
fi

    
