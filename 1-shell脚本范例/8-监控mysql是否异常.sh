#!/bin/bash
#方法一采用端口监控的方式监控
#if [ `netstat -lntup|grep "3306"|wc -l` -ge 1 ]
#if [ `netstat -lntup|grep mysql|wc -l` -ge 1 ]
#if [ `nmap 127.0.0.1 -p 3306|grap open|wc -l`  -ge 1 ]
if [ `ss -lntup|grep mysql|wc -l`  -ge 1  ]
    then
        echo  "mysql works normally!"
else
        echo "mysql error!"
fi

#方法二通过对服务进程或进程数进行监控,适用于本地服务器
if  [ `ps -ef|grep mysql|grep -v grep|wc -l` -ge 1 ]
    then
        echo  "mysql works normally!"
else
        echo "mysql error!"
fi

#方法三通过模拟用户访问的方式进行监控(主要使用wget和curl)
#实际使用过程则把百度地址替换为数据库的程序地址即可
wget --spider --timeout=10  --tries=2 www.baidu.com &>/dev/null
[ $? -eq 0 ] && echo mysql works normally! || echo mysql error!

curl -s  -o  /dev/null http://www.baidu.com
[ $? -eq 0 ] && echo mysql works normally! || echo mysql error!


