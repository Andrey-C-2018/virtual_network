#!/bin/bash

ip link add br2 type bridge
nmcli device set br2 managed no
ip link set br2 up

ip tuntap add tap-router-eth3 mode tap
nmcli device set tap-router-eth3 managed no
ip link set tap-router-eth3 up

ip tuntap add tap-user1 mode tap
nmcli device set tap-user1 managed no
ip link set tap-user1 up

ip link set tap-router-eth3 master br2
ip link set tap-user1 master br2