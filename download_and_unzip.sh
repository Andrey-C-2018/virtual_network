#!/bin/bash

if [ ! -f ./chr-7.18.2.img.zip ]
then
    wget https://download.mikrotik.com/routeros/7.18.2/chr-7.18.2.img.zip
fi

if [ ! -f ./chr-7.18.2.img ]
then
    unzip chr-7.18.2.img.zip
fi

if [ ! -f ./chr-7.19.2.img.zip ]
then
    wget https://download.mikrotik.com/routeros/7.19.2/chr-7.19.2.img.zip
fi

if [ ! -f ./chr-7.19.2.img ]
then
    unzip chr-7.19.2.img.zip
fi