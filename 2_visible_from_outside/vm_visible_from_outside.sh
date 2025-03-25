#!/bin/bash

qemu-system-x86_64 \
  -name mikrotik-chr \
  -enable-kvm \
  -m 256 \
  -smp 2 \
  -hda ../mikrotik-chr_simple.qcow2 \
  -nic bridge,br=br0,model=virtio \
  -nographic \
  -serial mon:stdio