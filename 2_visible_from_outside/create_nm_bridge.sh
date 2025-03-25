#!/bin/bash

# Необхідний пакет bridge-utils

IFACE=eno1
LAN_CONN=LAN

if nmcli connection show | grep -qw "bridge-br0"; then
    echo "Міст br1 існує."
else
    LAN_CONN_NAME=$(nmcli -t -f NAME,DEVICE connection show | grep ":$IFACE$" | cut -d: -f1)
    if [ -n "$LAN_CONN_NAME" ]; then
       echo "Видаляємо підключення: $LAN_CONN_NAME"
       nmcli connection delete "$LAN_CONN_NAME"
    else
       echo "Підключення для інтерфейсу $IFACE не знайдено."
    fi

    # Створення мосту
    nmcli con add type bridge ifname br0
    nmcli con mod bridge-br0 ipv4.method auto
fi

# Отримуємо список всіх список всіх інтерфейсів, що входять у bridge
SLAVE_INTERFACES=$(nmcli -t -f NAME connection show | grep -E "^bridge-slave-$IFACE|bridge-br0-")
# Видаляємо знайдені підключення
for CONN in $SLAVE_INTERFACES; do
    echo "Видаляємо: $CONN"
    nmcli connection delete "$CONN"
done

if nmcli connection show | grep -qw "LAN_CONN"; then
    nmcli connection down $LAN_CONN
    nmcli connection delete $LAN_CONN
fi

# Додавання вашого мережевого інтерфейсу до мосту
nmcli con add type bridge-slave ifname $IFACE master bridge-br0
#nmcli con modify bridge-slave-$IFACE connection.master bridge-br0
#nmcli con modify bridge-slave-$IFACE connection.slave-type bridge
nmcli con up bridge-br0

systemctl restart NetworkManager

nmcli device show eno1 | grep GENERAL.CONNECTION
nmcli device status
nmcli con show