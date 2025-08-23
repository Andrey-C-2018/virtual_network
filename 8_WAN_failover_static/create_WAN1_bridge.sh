#!/bin/bash

WAN1=eno1
WAN1_CONN_NAME=$(nmcli -t -f NAME,DEVICE connection show | grep ":$WAN1" | cut -d: -f1)

if nmcli connection show | grep -qw "bridge-br0"; then
    echo "Міст br0 існує."
else
    if [ -n "$WAN1_CONN_NAME" ]; then
       echo "Видаляємо підключення: $WAN1_CONN_NAME"
       nmcli connection down $WAN1_CONN_NAME
       nmcli connection delete $WAN1_CONN_NAME
    else
       echo "Підключення для інтерфейсу $WAN1 не знайдено."
    fi

    # Створення мосту
    nmcli con add type bridge ifname br0
    nmcli con mod bridge-br0 ipv4.method auto

    # Отримуємо список всіх список всіх інтерфейсів, що входять у bridge
    SLAVE_INTERFACES=$(nmcli -t -f NAME connection show | grep -E "^bridge-slave-$WAN1|bridge-br0-")
    # Видаляємо знайдені підключення
    for CONN in $SLAVE_INTERFACES; do
        echo "Видаляємо: $CONN"
        nmcli connection delete "$CONN"
    done

    # Додавання мережевого інтерфейсу WAN1 до мосту
    nmcli con add type bridge-slave ifname $WAN1 master bridge-br0
    nmcli device show $WAN1 | grep GENERAL.CONNECTION
fi

if ! ip link show dev tap-WAN1 &> /dev/null; then
   echo Creating TAP interface for WAN1
   ip tuntap add dev tap-WAN1 mode tap
   nmcli device set tap-WAN1 managed no
   ip link set tap-WAN1 master br0
   ip link set tap-WAN1 up
fi