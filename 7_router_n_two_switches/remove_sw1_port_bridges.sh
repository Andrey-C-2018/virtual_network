#!/bin/bash

ip tuntap del tap-sw1-uplink mode tap
ip tuntap del tap-sw1-eth3 mode tap
ip tuntap del tap-sw1-eth4 mode tap

ip link del br-sw1-eth3
ip link del br-sw1-eth4