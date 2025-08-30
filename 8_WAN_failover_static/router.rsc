# 2025-08-30 12:43:40 by RouterOS 7.18.2
# system id = rr/XU0tr2AP
#
/interface ethernet
set [ find default-name=ether4 ] disable-running-check=no name=ether1
set [ find default-name=ether1 ] disable-running-check=no name=ether2_WAN1
set [ find default-name=ether2 ] disable-running-check=no name=ether3_WAN2
set [ find default-name=ether3 ] disable-running-check=no name=ether4_cli
/interface list
add name=LAN
add name=WAN
/ip pool
add name=dhcp_pool0 ranges=172.16.1.2-172.16.1.200
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether4_cli lease-time=4h30m name=dhcp1
/port
set 0 name=serial0
/ipv6 settings
set disable-ipv6=yes
/interface list member
add interface=ether1 list=LAN
add interface=ether4_cli list=LAN
add interface=ether2_WAN1 list=WAN
add interface=ether3_WAN2 list=WAN
/ip address
add address=172.16.1.1/24 interface=ether4_cli network=172.16.1.0
/ip dhcp-client
add add-default-route=no default-route-tables=main interface=ether1 \
    use-peer-dns=no use-peer-ntp=no
add add-default-route=no interface=ether2_WAN1 use-peer-dns=no use-peer-ntp=\
    no
add add-default-route=no interface=ether3_WAN2 use-peer-dns=no use-peer-ntp=\
    no
/ip dhcp-server network
add address=172.16.1.0/24 dns-server=172.16.1.1 gateway=172.16.1.1
/ip dns
set allow-remote-requests=yes servers=1.0.0.3
/ip firewall filter
add action=accept chain=input protocol=icmp
add action=accept chain=input in-interface-list=LAN
add action=accept chain=input connection-state=established,related \
    in-interface-list=WAN
add action=drop chain=input
add action=accept chain=forward in-interface=ether4_cli out-interface-list=\
    WAN
add action=accept chain=forward connection-state=established,related \
    in-interface-list=WAN out-interface=ether4_cli
add action=drop chain=forward
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether2_WAN1
add action=masquerade chain=srcnat out-interface=ether3_WAN2
/ip firewall service-port
set pptp disabled=yes
/ip route
add dst-address=8.8.8.8 gateway=192.168.1.1 scope=10
add dst-address=8.8.4.4 gateway=192.168.8.1 scope=10
add check-gateway=ping distance=1 gateway=8.8.8.8 target-scope=11
add check-gateway=ping distance=2 gateway=8.8.4.4 target-scope=11
/system clock
set time-zone-autodetect=no time-zone-name=Europe/Kyiv
/system note
set show-at-login=no
