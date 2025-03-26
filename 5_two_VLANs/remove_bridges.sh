#!/bin/bash

ip tuntap del tap-router-eth0 mode tap
ip tuntap del tap-router-eth1 mode tap
ip tuntap del tap-router-eth2 mode tap
ip tuntap del tap-router-eth3 mode tap

ip tuntap del tap-user1 mode tap
ip tuntap del tap-user2 mode tap
ip tuntap del tap-user3 mode tap
ip tuntap del tap-user4 mode tap

ip link del br-eth0
ip link del br-eth1
ip link del br-eth2
ip link del br-eth3