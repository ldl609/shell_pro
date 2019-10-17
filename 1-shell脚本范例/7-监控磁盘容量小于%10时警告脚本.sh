#!/bin/bash
disk_free=`df -h|awk -F " " 'NR==2{print $5}'`
disk_free=${disk_free%\%*}
expr $disk_free + 1 &>/dev/null
[ $? -eq 0 ] && echo true || echo false
if  [ $disk_free  -lt  50  ]
    then
        echo "disk wull be fulll!" |tee /tmp/messages.txt
        mail -s "disk is full" 2671751255@qq.com </tmp/messages.txt
else
        echo "disk not full"
fi
