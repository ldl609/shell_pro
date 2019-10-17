#!/bin/bash
if [ $# -ne  1 ]
    then
        echo "pls input url."
        exit 1
fi

while true
do
    #通过获取状态码来验证网站是否正常
    if [ `curl -o /dev/null --connect-timeout  5 -s  -w "%{http_code}" $1|egrep -w "200|301|302"|wc -l` -ne 1 ]
        then
            echo "$1 connect error."
            echo "connect $1 error，"|mail -s "connect error" 2671751255@qq.com
    else
            echo "$1 connect OK."
    fi
    sleep 10
done
