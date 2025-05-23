#!/bin/bash

qemu-system-x86_64 \
  -name RouterOS-CHR \
  -enable-kvm \
  -m 256 \
  -smp 2 \
  -hda mikrotik-chr_router.qcow2 \
  -netdev tap,id=eth0,ifname=tap-router-eth0,script=no,downscript=no -device e1000,netdev=eth0,mac=52:54:00:11:11:11 \
  -netdev tap,id=eth1,ifname=tap-router-eth1,script=no,downscript=no -device e1000,netdev=eth1,mac=52:54:00:22:22:22 \
  -netdev tap,id=eth2,ifname=tap-router-eth2,script=no,downscript=no -device e1000,netdev=eth2,mac=52:54:00:33:33:33 \
  -netdev tap,id=eth3,ifname=tap-router-eth3,script=no,downscript=no -device e1000,netdev=eth3,mac=52:54:00:44:44:44 \
  -netdev user,id=eth4,hostfwd=tcp::8291-:8291 -device e1000,netdev=eth4 \
  -nographic \
  -serial mon:stdio