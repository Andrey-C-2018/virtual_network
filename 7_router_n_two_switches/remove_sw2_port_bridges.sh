#!/bin/bash

ip tuntap del tap-sw2-uplink mode tap
ip tuntap del tap-sw2-eth3 mode tap
ip tuntap del tap-sw2-eth4 mode tap

ip link del br-sw2-eth3
ip link del br-sw2-eth4