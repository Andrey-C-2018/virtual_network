# 2025-04-19 23:40:52 by RouterOS 7.18.1
# system id = dXenfEIkTIJ
#
/interface bridge
add name=bridge_LAN vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no name=ether1_WAN
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether3 ] disable-running-check=no
/interface vlan
add interface=bridge_LAN name=vlan10 vlan-id=10
add interface=bridge_LAN name=vlan20 vlan-id=20
/ip pool
add name=dhcp_pool0 ranges=172.16.10.2-172.16.10.250
add name=dhcp_pool1 ranges=172.16.20.2-172.16.20.250
/ip dhcp-server
add address-pool=dhcp_pool0 interface=vlan10 lease-time=4h30m name=\
    dhcp_vlan10
add address-pool=dhcp_pool1 interface=vlan20 lease-time=4h30m name=\
    dhcp_vlan20
/port
set 0 name=serial0
/interface bridge port
add bridge=bridge_LAN interface=ether2
add bridge=bridge_LAN interface=ether3
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge_LAN tagged=ether2,ether3,bridge_LAN vlan-ids=10,20
/ip address
add address=192.168.88.1/24 interface=bridge_LAN network=192.168.88.0
add address=172.16.10.1/24 interface=vlan10 network=172.16.10.0
add address=172.16.20.1/24 interface=vlan20 network=172.16.20.0
/ip dhcp-client
add interface=ether1_WAN
/ip dhcp-server network
add address=172.16.10.0/24 dns-server=172.16.10.1 gateway=172.16.10.1
add address=172.16.20.0/24 dns-server=172.16.20.1 gateway=172.16.20.1
/routing rule
add action=unreachable disabled=no dst-address=172.16.20.0/24 src-address=\
    172.16.10.0/24
add action=unreachable disabled=no dst-address=172.16.10.0/24 src-address=\
    172.16.20.0/24
/system clock
set time-zone-autodetect=no time-zone-name=Europe/Kiev
/system identity
set name=MikroTik-main
/system note
set show-at-login=no
