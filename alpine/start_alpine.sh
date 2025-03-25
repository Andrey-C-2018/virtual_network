#!/bin/bash

qemu-system-i386 \
  -name alpine1 \
  -enable-kvm \
  -m 64M \
  -smp 2 \
  -hda alpine-drive.qcow2 \
  -nic user \
  -boot d \
  -nographic \
  -serial mon:stdio