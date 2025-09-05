#!/bin/bash

WAN2_BRIDGE=br1
WAN2_PATTERN=enx
WAN2=$(nmcli -t -f DEVICE device | grep $WAN2_PATTERN)

if [ -z $WAN2 ]; then
    echo $WAN2_PATTERN - not found
    exit 1
fi

if [ "$(nmcli -g GENERAL.STATE device show $WAN2 | cut -d' ' -f1)" != "10" ]
then
    echo Setting $WAN2 as unmanaged
    nmcli device set $WAN2 managed no
fi

if ! ip link show dev $WAN2_BRIDGE &> /dev/null; then
   echo Creating the bridge
   ip link add name $WAN2_BRIDGE type bridge
   nmcli device set $WAN2_BRIDGE managed no
   ip link set dev $WAN2_BRIDGE up

   ip link set dev $WAN2 up
   ip link set dev $WAN2 master $WAN2_BRIDGE
fi

BRIDGE_IP=$(ip -4 addr show $WAN2_BRIDGE | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
if [ -z "$BRIDGE_IP" ]; then
    echo Obtaining the bridge address...
    dhcpcd --nohook resolv.conf $WAN2_BRIDGE
fi

if ! ip link show dev tap-WAN2 &> /dev/null; then
   echo Creating TAP interface for WAN2
   ip tuntap add dev tap-WAN2 mode tap
   nmcli device set tap-WAN2 managed no
   ip link set tap-WAN2 master $WAN2_BRIDGE
   ip link set tap-WAN2 up
fi

./firewall_WAN2_bridge.sh