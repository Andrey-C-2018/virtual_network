#!/bin/bash

IPTABLES="/sbin/iptables"
PHYS_IFACE=eno1
WAN1_BRIDGE=br0
TAP_IFACE=tap-WAN1

../firewall_dhcp.sh

# INPUT chain
$IPTABLES -A INPUT -p ICMP -i $WAN1_BRIDGE -s 0/0 --icmp-type 8 -j ACCEPT
$IPTABLES -A INPUT -p ICMP -i $WAN1_BRIDGE -s 0/0 --icmp-type 11 -j ACCEPT
$IPTABLES -A INPUT -i $WAN1_BRIDGE -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT


# FORWARD chain
$IPTABLES -A FORWARD -p icmp -i $WAN1_BRIDGE -o $WAN1_BRIDGE -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in $TAP_IFACE --physdev-out $PHYS_IFACE -p tcp -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in $PHYS_IFACE --physdev-out $TAP_IFACE -p tcp -m state --state RELATED,ESTABLISHED -j ACCEPT