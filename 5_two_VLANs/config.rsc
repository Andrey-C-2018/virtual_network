# 2025-03-26 15:35:57 by RouterOS 7.18.1
# system id = dXenfEIkTIJ
#
/interface bridge
add name=bridge1 vlan-filtering=yes
/interface ethernet
set [ find default-name=ether5 ] disable-running-check=no name=ether1_CTRL
set [ find default-name=ether1 ] disable-running-check=no name=ether2
set [ find default-name=ether2 ] disable-running-check=no name=ether3
set [ find default-name=ether3 ] disable-running-check=no name=ether4
set [ find default-name=ether4 ] disable-running-check=no name=ether5
/interface vlan
add interface=bridge1 name=vlan10 vlan-id=10
add interface=bridge1 name=vlan20 vlan-id=20
/interface list
add name=LAN
/ip pool
add name=dhcp_pool0 ranges=192.168.88.2-192.168.88.250
add name=dhcp_pool1 ranges=172.16.1.2-172.16.1.250
/ip dhcp-server
add address-pool=dhcp_pool0 interface=vlan10 name=dhcp1
add address-pool=dhcp_pool1 interface=vlan20 name=dhcp2
/port
set 0 name=serial0
/interface bridge port
add bridge=bridge1 interface=ether2 pvid=10
add bridge=bridge1 interface=ether3 pvid=20
add bridge=bridge1 interface=ether4 pvid=10
add bridge=bridge1 interface=ether5 pvid=20
/ipv6 settings
set disable-ipv6=yes
/interface bridge vlan
add bridge=bridge1 tagged=bridge1 vlan-ids=10
add bridge=bridge1 tagged=bridge1 vlan-ids=20
/interface list member
add interface=bridge1 list=LAN
add interface=*8 list=LAN
/ip address
add address=192.168.88.1/24 interface=vlan10 network=192.168.88.0
add address=172.16.1.1/24 interface=vlan20 network=172.16.1.0
add address=192.168.10.1/24 interface=bridge1 network=192.168.10.0
/ip dhcp-client
add interface=ether1_CTRL
/ip dhcp-server network
add address=172.16.1.0/24 dns-server=8.8.8.8 gateway=172.16.1.1
add address=192.168.88.0/24 dns-server=8.8.8.8 gateway=192.168.88.1
/routing rule
add action=drop disabled=no dst-address=172.16.1.0/24 src-address=\
    192.168.88.0/24
add action=drop disabled=no dst-address=192.168.88.0/24 src-address=\
    172.16.1.0/24
/system clock
set time-zone-name=Europe/Kiev
/system note
set show-at-login=no
