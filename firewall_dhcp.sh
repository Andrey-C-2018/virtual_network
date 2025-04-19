#!/bin/bash

IPTABLES="/sbin/iptables"

# INPUT chain
$IPTABLES -A INPUT -p udp --dport 67:68 -j ACCEPT
$IPTABLES -A OUTPUT -p udp --sport 67:68 -j ACCEPT

# FORWARD chain
$IPTABLES -A FORWARD -m physdev --physdev-out eno1 -p udp --dport 67:68 -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in eno1 -p udp --sport 67:68 -j ACCEPT
$IPTABLES -A FORWARD -p icmp -i br0 -o br0 -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in tap0 --physdev-out eno1 -p tcp -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in eno1 --physdev-out tap0 -p tcp -m state --state RELATED,ESTABLISHED -j ACCEPT