#!/bin/bash

qemu-system-i386 \
  -name alpine3 \
  -enable-kvm \
  -m 64M \
  -smp 2 \
  -hda client3.qcow2 \
  -netdev tap,id=net0,ifname=tap-user3,script=no,downscript=no -device e1000,netdev=net0,mac=52:54:00:AA:AA:AC \
  -boot d \
  -nographic \
  -serial mon:stdio