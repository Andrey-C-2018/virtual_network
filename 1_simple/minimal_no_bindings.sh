#!/bin/bash

qemu-system-x86_64 \
  -enable-kvm \
  -m 256M \
  -smp 2 \
  -hda mikrotik-chr_simple.qcow2 \
  -nographic \
  -serial mon:stdio