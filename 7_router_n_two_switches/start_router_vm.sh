#!/bin/bash

qemu-system-x86_64 \
  -name RouterOS-CHR-main \
  -enable-kvm \
  -m 256 \
  -smp 2 \
  -hda mikrotik-chr-router.qcow2 \
  -netdev user,id=eth1,hostfwd=tcp::8291-:8291 -device e1000,netdev=eth1 \
  -netdev tap,id=eth2,ifname=tap-router-eth2,script=no,downscript=no -device e1000,netdev=eth2,mac=52:54:00:22:22:22 \
  -netdev tap,id=eth3,ifname=tap-router-eth3,script=no,downscript=no -device e1000,netdev=eth3,mac=52:54:00:33:33:33 \
  -nographic \
  -serial mon:stdio