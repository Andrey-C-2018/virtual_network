#!/bin/bash

ip link add br-eth0 type bridge
ip link add br-eth1 type bridge
ip link add br-eth2 type bridge
ip link add br-eth3 type bridge

ip link set br-eth0 up
ip link set br-eth1 up
ip link set br-eth2 up
ip link set br-eth3 up

ip tuntap add tap-router-eth0 mode tap
ip tuntap add tap-router-eth1 mode tap
ip tuntap add tap-router-eth2 mode tap
ip tuntap add tap-router-eth3 mode tap

ip link set tap-router-eth0 up
ip link set tap-router-eth1 up
ip link set tap-router-eth2 up
ip link set tap-router-eth3 up

ip tuntap add tap-user1 mode tap
ip tuntap add tap-user2 mode tap
ip tuntap add tap-user3 mode tap
ip tuntap add tap-user4 mode tap

ip link set tap-user1 up
ip link set tap-user2 up
ip link set tap-user3 up
ip link set tap-user4 up

ip link set tap-router-eth0 master br-eth0
ip link set tap-user1 master br-eth0
ip link set tap-router-eth1 master br-eth1
ip link set tap-user2 master br-eth1
ip link set tap-router-eth2 master br-eth2
ip link set tap-user3 master br-eth2
ip link set tap-router-eth3 master br-eth3
ip link set tap-user4 master br-eth3

ip a