#!/bin/bash

IPTABLES="/sbin/iptables"
WAN2_BRIDGE=br1

$IPTABLES -A INPUT -p ICMP -i $WAN2_BRIDGE -s 0/0 --icmp-type 8 -j ACCEPT
$IPTABLES -A INPUT -p ICMP -i $WAN2_BRIDGE -s 0/0 --icmp-type 11 -j ACCEPT
$IPTABLES -A INPUT -i $WAN2_BRIDGE -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
