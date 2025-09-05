#!/bin/bash

IPTABLES="/sbin/iptables"
PHYS_IFACE=eno1

# INPUT chain
$IPTABLES -A INPUT -p udp --dport 67:68 -j ACCEPT
$IPTABLES -A OUTPUT -p udp --sport 67:68 -j ACCEPT

# FORWARD chain
$IPTABLES -A FORWARD -m physdev --physdev-out $PHYS_IFACE -p udp --dport 67:68 -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in $PHYS_IFACE -p udp --sport 67:68 -j ACCEPT