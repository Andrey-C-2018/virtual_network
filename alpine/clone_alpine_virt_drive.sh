#!/bin/bash

ROOT_DRIVE=$(dirname "$0")

qemu-img create -f qcow2 -b $ROOT_DRIVE/alpine-drive.qcow2 -F qcow2 new-vm.qcow2