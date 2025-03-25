#!/bin/bash

# Необхідний пакет bridge-utils

# Визначте ваш основний мережевий інтерфейс (зазвичай щось на кшталт eth0, enp0s3 тощо)
IFACE=$(ip route | grep default | awk '{print $5}')

# Створення мосту
ip link add name br0 type bridge
ip link set dev br0 up

# Додавання вашого мережевого інтерфейсу до мосту
ip link set dev $IFACE up
ip link set dev $IFACE master br0

# Якщо ваш інтерфейс використовує DHCP
sudo dhclient br0