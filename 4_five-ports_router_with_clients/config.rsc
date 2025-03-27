# 2025-03-27 11:11:50 by RouterOS 7.18.1
# system id = dXenfEIkTIJ
#
/interface bridge
add name=bridge1
add name=bridge2
/interface ethernet
set [ find default-name=ether5 ] disable-running-check=no name=ether1_CTRL
set [ find default-name=ether1 ] disable-running-check=no name=ether2
set [ find default-name=ether2 ] disable-running-check=no name=ether3
set [ find default-name=ether3 ] disable-running-check=no name=ether4
set [ find default-name=ether4 ] disable-running-check=no name=ether5
/interface list
add name=LAN
/ip pool
add name=dhcp_pool0 ranges=192.168.0.2-192.168.0.250
add name=dhcp_pool1 ranges=172.16.1.2-172.16.1.250
/ip dhcp-server
add address-pool=dhcp_pool0 interface=bridge1 name=dhcp1
add address-pool=dhcp_pool1 interface=bridge2 name=dhcp2
/port
set 0 name=serial0
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge2 interface=ether4
add bridge=bridge2 interface=ether5
/ipv6 settings
set disable-ipv6=yes
/interface list member
add interface=bridge1 list=LAN
add interface=bridge2 list=LAN
/ip address
add address=192.168.0.1/24 interface=bridge1 network=192.168.0.0
add address=172.16.1.1/24 interface=bridge2 network=172.16.1.0
/ip dhcp-client
add interface=ether1_CTRL
/ip dhcp-server network
add address=172.16.1.0/24 dns-server=8.8.8.8 gateway=172.16.1.1
add address=192.168.0.0/24 dns-server=8.8.8.8 gateway=192.168.0.1
/system clock
set time-zone-name=Europe/Kiev
/system note
set show-at-login=no
