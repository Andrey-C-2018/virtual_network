#!/bin/bash

qemu-system-x86_64 \
  -name mikrotik-chr \
  -enable-kvm \
  -m 256 \
  -smp 2 \
  -hda router.qcow2 \
  -netdev tap,id=eth1,ifname=tap-WAN1,script=no,downscript=no -device e1000,netdev=eth1,mac=52:54:00:22:22:22 \
  -netdev tap,id=eth2,ifname=tap-WAN2,script=no,downscript=no -device e1000,netdev=eth2,mac=52:54:00:33:33:33 \
  -netdev tap,id=eth3,ifname=tap-router-eth3,script=no,downscript=no -device e1000,netdev=eth3,mac=52:54:00:44:44:44 \
  -nographic \
  -serial mon:stdio