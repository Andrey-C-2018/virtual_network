#!/bin/bash

ip link add br-r-eth2 type bridge
ip link add br-r-eth3 type bridge

ip link set br-r-eth2 up
ip link set br-r-eth3 up

ip tuntap add tap-router-eth2 mode tap
ip tuntap add tap-router-eth3 mode tap

ip link set tap-router-eth2 up
ip link set tap-router-eth3 up

ip link set tap-router-eth2 master br-r-eth2
ip link set tap-router-eth3 master br-r-eth3