#!/bin/bash

ip tuntap add tap-cli1 mode tap
ip link set tap-cli1 up
ip link set tap-cli1 master br-sw1-eth3

ip tuntap add tap-cli2 mode tap
ip link set tap-cli2 up
ip link set tap-cli2 master br-sw1-eth4

ip tuntap add tap-cli3 mode tap
ip link set tap-cli3 up
ip link set tap-cli3 master br-sw2-eth3

ip tuntap add tap-cli4 mode tap
ip link set tap-cli4 up
ip link set tap-cli4 master br-sw2-eth4