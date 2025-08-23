#!/bin/bash

IPTABLES="/sbin/iptables"

# INPUT chain
$IPTABLES -A INPUT -p udp --dport 67:68 -j ACCEPT
$IPTABLES -A OUTPUT -p udp --sport 67:68 -j ACCEPT

# FORWARD chain
$IPTABLES -A FORWARD -m physdev --physdev-out eno1 -p udp --dport 67:68 -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in eno1 -p udp --sport 67:68 -j ACCEPT