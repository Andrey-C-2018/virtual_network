# 2025-09-06 12:29:05 by RouterOS 7.19.2
# system id = ao5rhkEmzJA
#
/interface ethernet
set [ find default-name=ether3 ] disable-running-check=no name=ether_LAN
set [ find default-name=ether2 ] disable-running-check=no name=ether_WAN1
set [ find default-name=ether1 ] disable-running-check=no name=\
    ether_forWinbox
/interface lte
set [ find default-name=lte1 ] name=lte_WAN2
/interface list
add name=WAN
add name=LAN
/ip pool
add name=dhcp_pool0 ranges=172.16.1.2-172.16.1.100
/ip dhcp-server
add address-pool=dhcp_pool0 interface=ether_LAN lease-time=4h30m name=dhcp1
/port
set 0 name=serial0
/routing table
add disabled=no fib name=to_ISP1
add disabled=no fib name=to_ISP2
/ip neighbor discovery-settings
set discover-interface-list=!WAN
/ipv6 settings
set disable-ipv6=yes
/interface list member
add interface=lte_WAN2 list=WAN
add interface=ether_WAN1 list=WAN
add interface=ether_forWinbox list=LAN
add interface=ether_LAN list=LAN
/ip address
add address=172.16.1.1/24 interface=ether_LAN network=172.16.1.0
/ip dhcp-client
add add-default-route=no interface=ether_forWinbox use-peer-dns=no \
    use-peer-ntp=no
add add-default-route=no interface=lte_WAN2 use-peer-dns=no use-peer-ntp=no
add add-default-route=no interface=ether_WAN1 use-peer-dns=no use-peer-ntp=no
/ip dhcp-server network
add address=172.16.1.0/24 gateway=172.16.1.1
/ip dns
set servers=1.0.0.3,8.8.8.8
/ip firewall filter
add action=accept chain=input comment="Related Established Untracked Allow" \
    connection-state=established,related,untracked
add action=accept chain=input comment="ICMP from ALL" protocol=icmp
add action=drop chain=input comment="All other WAN Drop" in-interface-list=\
    WAN
add action=accept chain=forward comment=\
    "Established, Related, Untracked allow" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="Invalid drop" connection-state=invalid
add action=drop chain=forward comment="Drop all from WAN not DSTNATed" \
    connection-nat-state=!dstnat connection-state=new in-interface-list=WAN
/ip firewall mangle
add action=accept chain=prerouting dst-address=192.168.1.0/24 \
    in-interface-list=LAN
add action=accept chain=prerouting dst-address=192.168.8.0/24 \
    in-interface-list=LAN

add action=mark-connection chain=prerouting connection-mark=no-mark \
    in-interface=ether_WAN1 new-connection-mark=ISP1_conn
add action=mark-connection chain=prerouting connection-mark=no-mark \
    in-interface=lte_WAN2 new-connection-mark=ISP2_conn

add action=mark-connection chain=prerouting connection-mark=no-mark \
    dst-address-type=!local in-interface-list=LAN new-connection-mark=\
    ISP1_conn per-connection-classifier=both-addresses:2/1
add action=mark-connection chain=prerouting connection-mark=no-mark \
    dst-address-type=!local in-interface-list=LAN new-connection-mark=\
    ISP2_conn per-connection-classifier=both-addresses:2/0

add action=mark-routing chain=prerouting connection-mark=ISP1_conn \
    in-interface-list=LAN new-routing-mark=to_ISP1
add action=mark-routing chain=prerouting connection-mark=ISP2_conn \
    in-interface-list=LAN new-routing-mark=to_ISP2

add action=mark-routing chain=output connection-mark=ISP1_conn \
    new-routing-mark=to_ISP1
add action=mark-routing chain=output connection-mark=ISP2_conn \
    new-routing-mark=to_ISP2

/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN

/ip route
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    192.168.1.1 routing-table=to_ISP1 suppress-hw-offload=no
add check-gateway=ping disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    192.168.8.1 routing-table=to_ISP2 suppress-hw-offload=no
add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=192.168.1.1 \
    routing-table=main suppress-hw-offload=no

/routing rule
add action=lookup dst-address=192.168.1.0/24 table=main
add action=lookup dst-address=10.0.2.0/24 table=main

/system clock
set time-zone-name=Europe/Kyiv
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
