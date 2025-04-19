#!/bin/bash

../firewall_dhcp.sh

IPTABLES="/sbin/iptables"

# FORWARD chain
$IPTABLES -A FORWARD -m physdev --physdev-out eno1 -p udp --dport 3310 -j ACCEPT
$IPTABLES -A FORWARD -m physdev --physdev-in eno1 -p udp --sport 3310 -j ACCEPT