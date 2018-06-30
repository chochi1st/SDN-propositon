#!/bin/bash

#---------------------- s1 -----------------------
## s1 - table 0
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=0,priority=50,in_port=1,actions=mod_vlan_vid:20,resubmit(,1)" # h1->h2 :  vlan20 ->>  table 1
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=0,priority=50,in_port=2,actions=mod_vlan_vid:30,resubmit(,1)" # h3->h4 :  vlan30 ->>  table 1
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=0,priority=60,dl_vlan=20,actions=resubmit(,2)"                # h2->h1 :  带vlan tag 20 标签 ->> table 2
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=0,priority=60,dl_vlan=30,actions=resubmit(,3)"                # h4->h3 :  带vlan tag 30 标签 ->> table 3
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=0,priority=40,in_port=patch12,actions=resubmit(,4)"           # 外网数据->> table4
sudo ovs-ofctl dump-flows  -O OpenFlow13 s1 table=0
## s1 - table 1
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=1,priority=50,dl_vlan=20,actions=output:patch12" # h1->h2 vlan:20 : output (chochi)
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=1,priority=50,dl_vlan=30,actions=output:patch12" # h3->h4 vlan:30 : output (chochi)
sudo ovs-ofctl dump-flows  -O OpenFlow13 s1 table=1
## s1 - table 2
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=2,priority=50,dl_vlan=20,actions=strip_vlan,output:1" # h2->h1 : output=(h1)
sudo ovs-ofctl dump-flows  -O OpenFlow13 s1 table=2
## s1 - table 3
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=3,priority=50,dl_vlan=30,actions=strip_vlan,output:2" # h4->h2 : output=(h3)
sudo ovs-ofctl dump-flows  -O OpenFlow13 s1 table=3
## s1 - table 4
sudo ovs-ofctl add-flow s1 -O OpenFlow13 "table=4,priority=50,actions=1,2"                            #外网数据输入

#---------------------- s2 ------------------------
# s2 - table 0
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=0,priority=50,in_port=1,actions=mod_vlan_vid:20,resubmit(,1)" # h2->h1 : vlan20 ->> table 1
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=0,priority=50,in_port=2,actions=mod_vlan_vid:30,resubmit(,1)" # h4->h3 : vlan30 ->> table 1
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=0,priority=60,dl_vlan=20,actions=resubmit(,2)"                # h1->h2 : 带vlan tag 20 标签 ->> table 2
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=0,priority=60,dl_vlan=30,actions=resubmit(,3)"                # h3->h4 : 带vlan tag 30 标签 ->> table 3
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=0,priority=40,in_port=patch22,actions=resubmit(,4)"           # 外网数据->> table4
sudo ovs-ofctl dump-flows  -O OpenFlow13 s2 table=0

# s2 - table 1
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=1,priority=50,dl_vlan=20,actions=output:patch22"         # h2->h1 : vlan20 output=(chochi)
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=1,priority=50,dl_vlan=30,actions=output:patch22"         # h4->h3 : vlan30 output=(chochi)
sudo ovs-ofctl dump-flows  -O OpenFlow13 s2 table=1

# s2 - table 2
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=2,priority=50,dl_vlan=20,actions=strip_vlan,output:1"         # h1->h2 : output=(h2)
sudo ovs-ofctl dump-flows  -O OpenFlow13 s2 table=2

# s2 -table 3
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=3,priority=50,dl_vlan=30,actions=strip_vlan,output:2"         # h3->h4 : output=(h4)
sudo ovs-ofctl dump-flows -O OpenFlow13 s2 table=3
# s2 - table 4
sudo ovs-ofctl add-flow s2 -O OpenFlow13 "table=4,priority=50,actions=1,2"                                    # 外网数据输入 
#####
##主机ping外网的数据流由chochi网桥处理。
