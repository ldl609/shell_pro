#!/bin/bash
#1.根据端口来判定是否异常
if [ `netstat -lntup|grep 80|wc -l` -gt 0 ]
    then
        echo "Nginx  is Running!"
else
        echo "Nginx is stopped!"
        #检测到Nginx未启动时启动,可通过which nginx查看
        /usr/sbin/nginx start
fi

#2.通过检测进程名称来判断异常
if [ `netstat -lntup|grep nginx|wc -l` -gt 0 ]
    then 
        echo "Nginx  is Running!"
else
        echo "Nginx is stopped!"
        nginx start
fi
#通过过滤
if [ `ps -ef|grep -v grep|grep nginx|wc -l` -gt 0 ]
    then
        echo "Nginx  is Running!"
else
        echo "Nginx is stopped!"
        nginx start
fi

#3.nmap检测方法,适合从远端进行检测,推荐使用
if [ `nmap 127.0.0.1 -p 80 2>/dev/null|grep open|wc -l` -gt 0 ]
    then
        echo "Nginx  is Running!"
else
        echo "Nginx is stopped!"
        nginx start
fi

#4.通过获取状态码来检测
if [ `curl -I http://127.0.0.1 2>/dev/null|head -1|egrep "200|302|301"|wc -l` -gt 0 ]
    then

        echo "Nginx  is Running!"
else
        echo "Nginx is stopped!"
        nginx start
fi





