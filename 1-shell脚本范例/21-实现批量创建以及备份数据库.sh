#!/bin/bash
PATH="/usr/local/mysql/bin:$PATH"
USER=root
PASSWORD=123456
SOCKET=/tmp/mysql.sock1
LOG_ON_CMD="mysql -u$USER -p$PASSWORD -S $SOCKET "

create_database(){
    #批量创建数据库
    data_list=(one tow three foru)
    for((i=0;i<${#data_list[*]};i++))
    do
        $LOG_ON_CMD -e "create database ${data_list[i]}"
    done
}

dump_database(){
    #数据库备份存储目录
    DBAPATH=/root
    #备份数据库指令
    DUMP_CMD="mysqldump -u$USER -p$PASSWORD -S $SOCKET "
    #若备份存储目录不存在则创建
    [ ! -d "$DBAPATH" ] && mkdir $DBAPATH

    #对获取到的数据库进行备份
    for dba_name in `$LOG_ON_CMD -e "show databases;"|sed '1d'|egrep -v "mysql|schema"`
    do
	echo "dba_name=$dba_name"
     	$DUMP_CMD  $dba_name|gzip >$DBAPATH/${dba_name}_$(date +%F).sql.gz
    done

}

create_database
dump_database
