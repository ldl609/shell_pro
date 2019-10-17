#!/bin/bash

user=liudl
for((num=10;num<=15;num++))
do
    password="`echo "ldlksjfsjkn$RANDOM"|md5sum|cut -c 3-12`"
    useradd $user$num &>/dev/null && echo "$password"|passwd --stdin $user$num &>/dev/null && echo -e "user:$user$num\tpasswd:$password">>user.log

    if [ $? -ne 0 ]
        then
            echo "$user$num is error."
    else
            echo "$user$num is ok."
    fi
done
