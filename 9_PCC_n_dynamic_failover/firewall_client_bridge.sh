#!/bin/bash

IPTABLES="/sbin/iptables"
PHYS_IFACE=eno1
CLIENT_BRIDGE=br2
CLIENT_TAP=tap-user1
ROUTER_TAP=tap-router-eth3

../firewall_dhcp.sh

# INPUT chain
$IPTABLES -A INPUT -p ICMP -i $CLIENT_BRIDGE -s 0/0 --icmp-type 8 -j ACCEPT
$IPTABLES -A INPUT -p ICMP -i $CLIENT_BRIDGE -s 0/0 --icmp-type 11 -j ACCEPT
$IPTABLES -A INPUT -i $CLIENT_BRIDGE -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# FORWARD chain
$IPTABLES -A FORWARD -p icmp -i $CLIENT_BRIDGE -o $CLIENT_BRIDGE -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in $CLIENT_TAP --physdev-out $PHYS_IFACE -p tcp -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in $PHYS_IFACE --physdev-out $CLIENT_TAP -p tcp -m state --state RELATED,ESTABLISHED -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in $ROUTER_TAP --physdev-out $PHYS_IFACE -p tcp -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in $PHYS_IFACE --physdev-out $ROUTER_TAP -p tcp -m state --state RELATED,ESTABLISHED -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in $CLIENT_TAP --physdev-out $ROUTER_TAP -p tcp -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in $ROUTER_TAP --physdev-out $CLIENT_TAP -p tcp -j ACCEPT