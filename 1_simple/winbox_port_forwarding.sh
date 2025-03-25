#!/bin/bash

qemu-system-x86_64 \
    -enable-kvm \
    -m 256M \
    -smp 2 \
    -drive file=../mikrotik-chr_simple.qcow2,if=virtio \
    -net nic,model=e1000 \
    -net user,hostfwd=tcp::8291-:8291 \
    -nographic \
    -serial mon:stdio