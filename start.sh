#!/bin/sh

#based on SoarinFerret/iptablesproxy

if [ -z "$ALLOW_FROM" ]; then
  echo "Environment variable ALLOW_FROM must be set."; exit 1;
fi

#localhost
iptables -A INPUT -s 127.0.0.1 -j ACCEPT

## ...and check for privileged access real quickly like
if ! [ $? -eq 0 ]; then
    echo "Sorry, this container requires the '--cap-add=NET_ADMIN' flag to be set in order to use for iptables"; exit 1;
fi

#from other containers
iptables -A INPUT -s 172.16.0.0/12 -j ACCEPT
#outgoing established
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

IFS=", "

for FROM in $ALLOW_FROM; do
    iptables -A INPUT -s "$FROM" -j ACCEPT
done

iptables -A INPUT -j DROP

sleep 100000000000