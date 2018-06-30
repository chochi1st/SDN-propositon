# NOTE
- Ubuntu18.04,OpenVswitch2.9.0,Mininet2.3
- chochi 网桥不能连控制器，不然物理主机无法通外网，目前不知道原因 = =
- 虚拟主机的IPbase 192.168.0.0/16（mininet 默认10.0.0.1/8）,OpenFlow13协议, s1连h1,h3主机，s2连h2,h4主机，s1与s2之间没有链路互通，必须通过网桥chochi
- 将电脑的物理网卡eth0加入到chochi网桥，并创建两对patch_port，将chochi<->s1, chochi<->s2相链接
- topo 在vlan.mn文件中，用mininet的可视化打开该文件，并开启本机ODL控制器（127.0.0.1：6633）。
- 通外网操作我选择了同一个实验室（一个校园网）里的另外一台主机来互通，所以直接限制了IP，使用者可以在流表里面自己做修改。
# 说明
![](/云计算-vlan隔离/20180629/topo.png)
## VLAN 隔离
VLAN20：H1,H2 VLAN30：H3,H4
# 实验步骤
1. 开启ODL控制器，在Mininet可视化中打开vlan.mn文件运行拓扑。
2. 在终端中运行chochi_final.sh脚本、vlan.sh脚本，这两个脚本运行有序！（注意修改IP）
3. 完成，可以自己做一些测试。

# 这个是简化版本！很多地方写死了！还有MAC Learning和端口映射没有做！我有空在弄！
