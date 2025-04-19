#!/bin/bash

# Необхідний пакет bridge-utils

IFACE=eno1
LAN_CONN=LAN

if nmcli connection show | grep -qw "bridge-br0"; then
    nmcli conn down bridge-br0

    # Отримуємо список всіх список всіх інтерфейсів, що входять у bridge
    SLAVE_INTERFACES=$(nmcli -t -f NAME connection show | grep -E "^bridge-slave-$IFACE|bridge-br0-")
    # Видаляємо знайдені підключення
    for CONN in $SLAVE_INTERFACES; do
        echo "Видаляємо: $CONN"
        nmcli connection delete "$CONN"
    done

    nmcli connection delete bridge-br0
fi

if ! nmcli connection show | grep -qw "$LAN_CONN"; then
    nmcli connection add type ethernet con-name "$LAN_CONN" ifname "$IFACE"
    nmcli connection modify "$LAN_CONN" ipv4.method auto
    nmcli connection up "$LAN_CONN"
fi

nmcli connection show