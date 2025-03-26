#!/bin/bash

ip tuntap del tap-router-eth0 mode tap
ip tuntap del tap-user1 mode tap
ip link del br-eth0