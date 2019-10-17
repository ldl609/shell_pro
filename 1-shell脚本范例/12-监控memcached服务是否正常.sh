#!/bin/bash
printf "del key\r\n"|nc 127.0.0.1 11211 &>dev/null
printf "set key 0 0 10 \r\nldl609\r\n"|nc 127.0.0.1 11211 &>/dev/null

mcvalues=`printf "get key\r\n"|nc 127.0.0.1 11211|grep "ldl609"|wc -l`
if [ $mcvalues -eq 1]
    then
        echo "memcached status is ok!"
else
        echo "memcached status is bad!"
fi

