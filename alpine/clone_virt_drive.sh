#!/bin/bash

qemu-img create -f qcow2 -b alpine-drive.qcow2 -F qcow2 new-vm.qcow2