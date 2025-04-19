#!/bin/bash

ip tuntap add tap-sw2-uplink mode tap
ip link set tap-sw2-uplink up
ip link set tap-sw2-uplink master br-r-eth3

ip link add br-sw2-eth3 type bridge
ip link add br-sw2-eth4 type bridge

ip link set br-sw2-eth3 up
ip link set br-sw2-eth4 up

ip tuntap add tap-sw2-eth3 mode tap
ip tuntap add tap-sw2-eth4 mode tap

ip link set tap-sw2-eth3 up
ip link set tap-sw2-eth4 up

ip link set tap-sw2-eth3 master br-sw2-eth3
ip link set tap-sw2-eth4 master br-sw2-eth4