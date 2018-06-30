# chochi 网桥不能连控制器，不然物理主机无法通外网
# 虚拟主机的IPbase 192.168.0.0/16,OpenFlow13, s1连h1,h3主机，s2连h2,h4主机，s1与s2之间没有链路互通，必须通过网桥chochi
# 将电脑的物理网卡eth0加入到chochi网桥，并创建两对patch_port，将chochi<->s1, chochi<->s2相链接
# topo 在vlan.mn文件中，用mininet的可视化打开该文件，并开启控制器。
