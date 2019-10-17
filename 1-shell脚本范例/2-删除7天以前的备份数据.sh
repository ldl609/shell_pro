#!/bin/bash
# 实现删除7天前的过期备份数据
backup_dir="/root/shell_work"  #存放备份数据的路径
:<<eof
l_ex_file=`find ${backup_dir} -name '*.tar.gz' -type f -mtime +7`
rm -f ${l_ex_file}
eof

find $l_ex_file -name '*.tar.gz' -type f -mtime +7|xargs rm -f

if [[ $?==0 ]]
    then
        echo "delete 7 backup data successfuly!"
fi
