#!/bin/bash

ip link add br-eth0 type bridge
ip link set br-eth0 up

ip tuntap add tap-router-eth0 mode tap
ip tuntap add tap-user1 mode tap

ip link set tap-router-eth0 up
ip link set tap-user1 up

ip link set tap-router-eth0 master br-eth0
ip link set tap-user1 master br-eth0

ip a