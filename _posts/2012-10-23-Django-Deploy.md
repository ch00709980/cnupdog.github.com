---
layout: post
title: 开始使用Django(二)
category: django
---  

    将Django部署到线上，可选的web服务器常见有：nginx、apche、lighttpd等，查阅了若干资料对比「文章」之后，决定选择Nginx + uwsgi作为部署方案，下面介绍一下基础环境准备。

系统为下图所示
<img src="/assets/img/django/django-sys-version.jpg" width="100%" />


Python2.7安装
--------------
> 由于后面步骤准备安装的virtualenv（虚拟环境）依赖python2.5+，所以需要提前装好较高版本的Python  
> 为了后面便于卸载，建议在/root/跟目录下新建一个文件夹install存放所有的软件包源码

1. cd /root/ && mkdir install && cd install
2. wget http://www.python.org/ftp/python/2.7.1/Python-2.7.1.tar.bz2
3. tar -jxvf Python-2.7.1.tar.bz2
4. cd Python-2.7.1
5. ./configure \-\-prefix=/usr/local/python2.7.1  
> 建议指定最终的安装目录，即使用--prefix指令，否则后续可执行文件会被默认放在/usr/local/bin，库文件会被默认放在/usr/local/lib，配置文件默认放在/usr/local/etc，资源文件放在/usr/local/share，非常不利于软件卸载
6. make && make install
7. cd /usr/bin  
8. ll \| grep python 
9. rm -rf python 
10. ln -s /usr/local/python2.7.1/bin/python ./python
11. python

Virtualenv安装
--------------
> Virtualenv用于在一台机器上创建多个隔离的python运行环境。主要隔离项目间的第三方包依赖

1. wget -q http://peak.telecommunity.com/dist/ez_setup.py
> easy_install是由PEAK开发的setuptools包里带的一个命令，使用easy_install实际上是在调用setuptools来完成安装模块的工作。
2. python ez_setup.py
3. easy_install virtualenv
4. virtualenv –h    
>  熟悉virtualenv指令
5. virtualenv \-\-no-site-packages django    
>  如果想完全不依赖系统的packages，可以加上参数--no-site-packages来创建虚拟环境，名字叫做“django”
6. cd django/ && source bin/activate  
7. pip install django  
8. pip install uwsgi  
9. pip install supervisor  
> 多进程管理，可以选择不安装

Nginx安装
--------------
> 一般用源码编译安装Nginx，都需要先安装pcre\zlib等外部支持程序，然后配置安装nginx时候这些外部程序的***源码***的路径，这样Nginx在每次启动的时候，就会动态地去加载这些东西了。***后面是否对这些外部程序单独编译，自己决定，不编译影响不大***

安装PCRE外部程序

1. cd /root/install
2. wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.30.tar.gz
3. tar -zxvf pcre-8.30.tar.gz  
4. cd pcre-8.30  
5. ./configure \-\-prefix=/usr/local/pcre8.30  
6. make && make install

安装OPENSSL外部程序  

1. cd /root/install  
2. wget http://www.openssl.org/source/openssl-1.0.0a.tar.gz  
3. tar -zxvf openssl-1.0.0a.tar.gz  
4. cd openssl-1.0.0a  
5. ./config \-\-prefix=/usr/local/openssl1.0.0  
6. make && make install 

安装ZLIB外部程序  
1. cd /root/install  
2. wget http://www.zlib.net/zlib-1.2.7.tar.bz2  
3. tar -jxvf zlib-1.2.7.tar.bz2  
4. cd zlib-1.2.7  
5. ./configure \-\-prefix=/usr/local/zlib1.2.7  
6. make && make install  

最后安装NGINX  

1. cd /root/install  
2. wget http://nginx.org/download/nginx-1.0.15.tar.gz  
3. tar -zxvf nginx-1.0.15.tar.gz  
4. cd nginx-1.0.15  
5. ./configure \-\-prefix=/usr/local/nginx \-\-with-http_realip_module \-\-with-http_sub_module \-\-with-http_flv_module \-\-with-http_dav_module \-\-with-http_gzip_static_module \-\-with-http_stub_status_module \-\-with-http_addition_module \-\-with-pcre=/root/install/pcre-8.30 \-\-with-openssl=/root/install/openssl-1.0.0a \-\-with-http_ssl_module \-\-with-zlib=/root/install/zlib-1.2.7  
> 这里指定的是全部源码的绝对路径  
6. make && make install

