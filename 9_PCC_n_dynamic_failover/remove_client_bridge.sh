#!/bin/bash

ip tuntap del tap-router-eth3 mode tap
ip tuntap del tap-user1 mode tap
ip link del br2