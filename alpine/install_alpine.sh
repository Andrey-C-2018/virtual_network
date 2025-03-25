#!/bin/bash

qemu-system-i386 \
  -name alpine1 \
  -enable-kvm \
  -m 512M \
  -smp 2 \
  -hda alpine-drive.qcow2 \
  -cdrom alpine-virt-3.21.3-x86.iso \
  -nic user \
  -boot d