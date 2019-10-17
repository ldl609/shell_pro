#!/bin/bash

free_mem=`free -m|awk  -F " " 'NR==2{print $4}'`
echo "free_mem=${free_mem}"
send_message="Cueeent memory is ${free_mem}."

if [ $free_mem -lt 400  ]
    then
        #把警告信息写到文件中用于发送邮件的正文
        echo $send_message |tee /tmp/messages.txt

        mail -s "`date  +%F-%T`$send_message"  2671751255@qq.com </tmp/messages.txt
        [ $? -eq 0 ] && echo send successfuly! || echo senf error!
fi




