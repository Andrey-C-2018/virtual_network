#!/bin/bash

qemu-system-i386 \
  -name alpine2 \
  -enable-kvm \
  -m 64M \
  -smp 2 \
  -hda client2.qcow2 \
  -netdev tap,id=net0,ifname=tap-user2,script=no,downscript=no -device e1000,netdev=net0,mac=52:54:00:AA:AA:AB \
  -boot d \
  -nographic \
  -serial mon:stdio