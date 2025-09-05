#!/bin/bash

WAN1=eno1
WAN1_CONN_NAME=LAN

if nmcli connection show | grep -qw "bridge-br0"; then
    echo Removing TAP interface for WAN1
    ip tuntap del tap-WAN1 mode tap

    echo Shutting down NetworkManager bridge connection bridge-br0
    nmcli conn down bridge-br0

    # Отримуємо список всіх список всіх інтерфейсів, що входять у bridge
    SLAVE_INTERFACES=$(nmcli -t -f NAME connection show | grep -E "^bridge-slave-$WAN1|bridge-br0-")
    # Видаляємо знайдені підключення
    for CONN in $SLAVE_INTERFACES; do
        echo "Removing: $CONN"
        nmcli connection delete "$CONN"
    done

    echo Removing NetworkManager bridge connection bridge-br0
    nmcli connection delete bridge-br0
fi

if ! nmcli connection show | grep -qw "$WAN1_CONN_NAME"; then
    echo "Restoring the WAN1 NM connection for dev $WAN1"
    nmcli connection add type ethernet con-name "$WAN1_CONN_NAME" ifname "$WAN1"
    nmcli connection modify "$WAN1_CONN_NAME" ipv4.method auto
    nmcli connection modify "$WAN1_CONN_NAME" ipv6.method "disabled"
    nmcli connection up "$WAN1_CONN_NAME"
fi