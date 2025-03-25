#!/bin/bash

qemu-system-x86_64 \
  -name RouterOS-CHR \
  -enable-kvm \
  -m 256 \
  -smp 2 \
  -hda mikrotik-chr_router.qcow2 \
  -netdev tap,id=eth0,ifname=tap-router-eth0,script=no,downscript=no -device e1000,netdev=eth0,mac=52:54:00:11:11:11 \
  -nographic \
  -serial mon:stdio