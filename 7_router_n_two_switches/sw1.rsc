# 2025-04-19 23:42:52 by RouterOS 7.18.1
# system id = dXenfEIkTIJ
#
/interface bridge
add name=bridge_LAN vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1_MGMT
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
set [ find default-name=ether4 ] disable-running-check=no
/port
set 0 name=serial0
/interface bridge port
add bridge=bridge_LAN interface=ether2
add bridge=bridge_LAN interface=ether3 pvid=10
add bridge=bridge_LAN interface=ether4 pvid=20
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge_LAN tagged=ether2,bridge_LAN untagged=ether3 vlan-ids=10
add bridge=bridge_LAN tagged=ether2,bridge_LAN untagged=ether4 vlan-ids=20
/ip address
add address=192.168.88.10/24 interface=bridge_LAN network=192.168.88.0
/ip dhcp-client
add interface=ether1_MGMT
/system clock
set time-zone-autodetect=no time-zone-name=Europe/Kiev
/system identity
set name=MikroTik-sw1
/system note
set show-at-login=no
