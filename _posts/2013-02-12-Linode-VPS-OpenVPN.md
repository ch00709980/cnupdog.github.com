---
layout: post
title: Linode VPS搭建OPENVPN
category: programming
--- 
一直想租台VPS，安装想要的OS，搭建Web服务器，也顺便搭建各种代理，上国内无法上的网站。查了一些资料，最终挑选了Linode提供的VPS（512M内存, 16GB硬盘, 200GB流量/月 = **$19.95**/月，最低配置）  
有同样需求却不知道如何挑选VPS主机商的朋友可以参照：[哪款海外 VPS 性价比高？](http://www.zhihu.com/question/19904241)

## 如何购买VPS

前人已经总结了：[Linode VPS使用和购买指南](http://linode.ofeva.com/)

另外需要注意几点：  
1. **如何续费？**绑定信用卡会自己扣费。  
2. **停止服务？**在Linode面板中将所有Linode都Remove掉即可，会自动按照剩余时常退回到Linode帐号中（有任何问题都可以发送Ticket过去，一般2分钟即可获得答复）  
3. **挑选机房？**Linode提供6个机房，建议选择**Fremont**，不建议选择<del>Tokyo</del>，虽然是最新的机房，但大量中国的新用户涌入使用，延迟开始大了，另外还可能因为中日关系交恶而收到影响。  
4. **OS选择？**很奇怪现在大多人都选择安装Ubuntu当server OS，但我还是最终选择了更传统的CENTOS6，因为CentOS和RedHat Enterprise源码一样，RHEL每五年左右更新一次，稳定安全且使得我们几乎不用去考虑升级的问题，另外我非常喜欢用yum命令（下载、升级软件超级方便）。 

## 通过OpenVPN部署VPN服务

这点Linode的官方Guides写的非常详细，可以直接参考[Secure Communications with OpenVPN on CentOS 6](http://library.linode.com/networking/openvpn)

### 步骤及说明
1. rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm     
2. yum update   
3. yum install openvpn  
4. cp -R /usr/share/openvpn/easy-rsa/ /etc/openvpn  
5. vim /etc/openvpn/easy-rsa/2.0/vars  
6. cd /etc/openvpn/easy-rsa/2.0/  
7. cp /etc/openvpn/easy-rsa/2.0/openssl-1.0.0.cnf openssl.cnf  
8. . /etc/openvpn/easy-rsa/2.0/vars  
9. . /etc/openvpn/easy-rsa/2.0/clean-all  
10. . /etc/openvpn/easy-rsa/2.0/build-ca  
11. . /etc/openvpn/easy-rsa/2.0/build-key-server server  
12. . /etc/openvpn/easy-rsa/2.0/build-key client-cnupdog  
13. . /etc/openvpn/easy-rsa/2.0/build-dh  
14. cd /etc/openvpn/easy-rsa/2.0/keys  
15. cp ca.crt ca.key dh1024.pem server.crt server.key /etc/openvpn  
16. cp /usr/share/doc/openvpn-2.2.2/sample-config-files/server.conf /etc/openvpn/  
17. vim /etc/openvpn/server.conf  

    $ git config --global color.ui true    
	
18. cp /usr/share/doc/openvpn-2.2.2/sample-config-files/client.conf ~/cnupdog-client.conf  
19. iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE  


### 其他注意
待定


-EOF-

