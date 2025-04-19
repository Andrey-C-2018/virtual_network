#!/bin/bash

qemu-system-x86_64 \
  -name RouterOS-CHR-sw1 \
  -enable-kvm \
  -m 256 \
  -smp 2 \
  -hda mikrotik-chr-switch1.qcow2 \
  -netdev user,id=eth1,hostfwd=tcp::8292-:8291 -device e1000,netdev=eth1 \
  -netdev tap,id=eth2,ifname=tap-sw1-uplink,script=no,downscript=no -device e1000,netdev=eth2,mac=52:54:00:A1:11:11 \
  -netdev tap,id=eth3,ifname=tap-sw1-eth3,script=no,downscript=no -device e1000,netdev=eth3,mac=52:54:00:A2:22:22 \
  -netdev tap,id=eth4,ifname=tap-sw1-eth4,script=no,downscript=no -device e1000,netdev=eth4,mac=52:54:00:A3:33:33 \
  -nographic \
  -serial mon:stdio