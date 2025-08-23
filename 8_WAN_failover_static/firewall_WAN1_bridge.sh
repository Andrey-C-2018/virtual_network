#!/bin/bash

IPTABLES="/sbin/iptables"
WAN1_BRIDGE=br0

../firewall_dhcp.sh

$IPTABLES -A INPUT -p ICMP -i $WAN1_BRIDGE -s 0/0 --icmp-type 8 -j ACCEPT
$IPTABLES -A INPUT -p ICMP -i $WAN1_BRIDGE -s 0/0 --icmp-type 11 -j ACCEPT
$IPTABLES -A INPUT -i $WAN1_BRIDGE -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
