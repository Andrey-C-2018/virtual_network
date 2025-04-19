#!/bin/bash

ip tuntap del tap-router-eth2 mode tap
ip tuntap del tap-router-eth3 mode tap

ip link del br-r-eth2
ip link del br-r-eth3