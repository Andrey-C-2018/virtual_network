#!/bin/bash

WAN2_BRIDGE=br1

echo Removing TAP interface for WAN2
ip tuntap del tap-WAN2 mode tap

echo Removing the bridge $WAN2_BRIDGE
ip link set dev $WAN2_BRIDGE down
ip link del $WAN2_BRIDGE