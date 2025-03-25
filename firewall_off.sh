#!/bin/sh

IPTABLES="/sbin/iptables"

# Clean all chains
$IPTABLES -F
$IPTABLES -t nat -F
$IPTABLES -t mangle -F

$IPTABLES -X

# Policies by default
$IPTABLES -P INPUT ACCEPT
$IPTABLES -P OUTPUT ACCEPT
$IPTABLES -P FORWARD ACCEPT