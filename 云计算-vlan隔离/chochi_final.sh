#!/bin/bash
sudo ovs-vsctl add-br chochi
ifconfig eth0 0
sudo ovs-vsctl add-port chochi eth0
sudo dhclient chochi
ping www.baidu.com -c 2
sudo ovs-vsctl add-port chochi patch11 -- set interface patch11 type=patch options:peer=patch12
sudo ovs-vsctl add-port s1     patch12 -- set interface patch12 type=patch options:peer=patch11
sudo ovs-vsctl add-port chochi patch21 -- set interface patch21 type=patch options:peer=patch22
sudo ovs-vsctl add-port s2     patch22 -- set interface patch22 type=patch options:peer=patch21
ping www.baidu.com -c 2

# flow entry
sudo ovs-ofctl add-flow chochi  "priority=100,in_port=eth0,arp,actions=normal"  #外网向内发送的arp
sudo ovs-ofctl add-flow chochi  "priority=100,in_port=eth0,icmp,actions=normal" #外网向内发送的icmp
sudo ovs-ofctl add-flow chochi  "priority=80,vlan_vid=0x1000/0x1000,arp,arp_tpa=192.168.0.0/16,actions=normal" # 内网的arp
sudo ovs-ofctl add-flow chochi  "priority=80,vlan_vid=0x1000/0x1000,icmp,nw_dst=192.168.0.0/16,actions=normal" #内网的icmp
sudo ovs-ofctl add-flow chochi  "priority=50,in_port=patch11,vlan_vid=0x1000/0x1000,actions=strip_vlan,eth0" # 不是要向内网发送的数据，剥离vlan tag
sudo ovs-ofctl add-flow chochi  "priority=50,in_port=patch21,vlan_vid=0x1000/0x1000,actions=strip_vlan,eth0"
sudo ovs-ofctl add-flow chochi  "priority=10,actions=normal" #table-miss packets
