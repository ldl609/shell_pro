#!/bin/bash
mysql_file_path=""
first_old_password=""
second_old_password=""
third_old_password=""
new_password="123456"

#1.获取mysql安装文件
get_mysql_install_file(){
    if [ $1 -lt 1 ]
        then
            read -p "pls input mysql install file path:" mysql_file_path
    else
            mysql_file_path=$2
    fi
    echo -e "\E[1;31m mysql_file_path=$mysql_file_path \E[0m"
}

#2.第一步先关闭SELinux
close_SELinux(){
    #修改selinux配置文件/etc/selinux/config
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    #设置当前不启用selinux
    setenforce=0
    #查看selinux状态
    selinux_status=`getenforce`
    echo -e "\E[1;31m selinux_status=$selinux_status \E[0m"
    if [[ "$selinux_status" == "Permissive"  ]]
        then
            echo "close selinux successful."
    else
            echo "close selinux error."
            #exit 1
    fi
}

#3.关闭防火墙用于远程登陆mysql
close_firewall(){
    #查看防火墙状态
    #firewall-cmd  --state
    #停止防火墙
    systemctl stop firewalld.service
    #禁止firewall开机启动
    #systemctl disable firewalld.service

    if [[ "`firewall-cmd  --state`" == "running" ]]
        then
            echo "stop firewall error."
    else
            echo "stop firewall successful."
    fi
}


#4.安装mysql
install_mysql(){
    #创建mysql安装目录,安装路径为:/usr/local/maysql
    mkdir -p /usr/local/mysql
    #解压安装文件,并且把解压后的文件拷贝到mysql安装路径
    echo "Unzipping the file........"
    tar -zxvf $mysql_file_path &>/dev/null
    echo `mv  ${mysql_file_path%.t*z}/*  /usr/local/mysql`

    if [ $? -lt 1 ]
        then
            echo "install mysql successful."
    else    
            echo "copy file error."
	    exit 2
    fi
}

#5.配置mysql多实例
add_mysql_multi_instance(){
    #创建m不能登陆的mysql用户
    useradd mysql -r -s /sbin/nologin
    #创建数据导入导出目录
    mkdir   -p /usr/local/mysql/mysql_files
    #创建多实例数据目录,这里创建3个实例分别为mysql_3306,mysql_3307,mysql_3308
    mkdir   -p /data/mysql_{3306,3307,3308}
    #修改目录的属组及用户(将/usr/local/mysql下的所有文件为root用户拥有,群体的使用者为mysql)
    chown root.mysql -R /usr/local/mysql
    [ $? -eq 0 ] && echo change successful. || echo change error.
    #修改专用目录的属主及属组
    chown mysql.mysql -R /usr/local/mysql/mysql_files  /data/mysql_{3306,3307,3308}
    [ $? -eq 0 ] && echo change successful. || echo change error.
}

#6.配置mysql的配置文件/etc/my.cnf
set_mycnf_file(){
    mv /etc/my.cnf /etc/my.cnf.backup

    cat>>/etc/my.cnf<<EOF
[mysqld_multi]
mysqld = /usr/local/mysql/bin/mysqld
mysqladmin = /usr/local/mysql/bin/mysqladmin
log = /tmp/mysql_multi.log

[mysqld1]
datadir = /data/mysql_3306
socket = /tmp/mysql.sock1
port = 3306
user = mysql
performance_schema = off
innodb_buffer_pool_size = 32M
bind_address = 0.0.0.0
skip-name-resolve = 0

[mysqld2]
datadir = /data/mysql_3307
socket = /tmp/mysql.sock2
port = 3307
user = mysql
performance_schema = off
innodb_buffer_pool_size = 32M
bind_address = 0.0.0.0
skip-name-resolve = 0

[mysqld3]
datadir = /data/mysql_3308
socket = /tmp/mysql.sock3
port = 3308
user = mysql
performance_schema = off
innodb_buffer_pool_size = 32M
bind_address = 0.0.0.0
skip-name-resolve = 0
EOF
echo "set file '/etc/my.cnf' successful."
#配置文件选项说明
:<<eof
#设置数据目录
datadir = /data/mysql_3308 
#设置sock文件存放路径
socket = /tmp/mysql.sock3
#设置监听端口
port = 3308
#设置运行用户
user = mysql
#设置关闭监控
performance_schema = off
#设置innodb缓存大小
innodb_buffer_pool_size = 32M
#设置监听ip地址
bind_address = 0.0.0.0
#关闭DNS反向解析
skip-name-resolve = 0
eof
}

#7.初始化各个实例,初始化后会在日志中生成密码注意保存,后续会用
init_mysql_instance(){
     #初始化第一个实例
     /usr/local/mysql/bin/mysqld  --initialize --user=mysql  --basedir=/usr/local/mysql  --datadir=/data/mysql_3306 &>/root/passwordinfo.txt
     [ $? -eq 0 ] && echo "init mysql_3306 successful." || echo "init mysql_3306 error"
     first_old_password=`cat /root/passwordinfo.txt|grep "password.*root@localhost:" | awk -F ": " '{print $NF}'`
     
     #初始化第二个实例
     /usr/local/mysql/bin/mysqld  --initialize --user=mysql  --basedir=/usr/local/mysql  --datadir=/data/mysql_3307 &>/root/passwordinfo.txt
     [ $? -eq 0 ] && echo "init mysql_3307 successful." || echo "init mysql_3307 error"
     second_old_password=`cat /root/passwordinfo.txt|grep "password.*root@localhost:" | awk -F ": " '{print $NF}'`
     
     #从初始化第三个实例
     /usr/local/mysql/bin/mysqld  --initialize --user=mysql  --basedir=/usr/local/mysql  --datadir=/data/mysql_3308 &>/root/passwordinfo.txt
     [ $? -eq 0 ] && echo "init mysql_3308 successful." || echo "init mysql_3308 error"
     third_old_password=`cat /root/passwordinfo.txt|grep "password.*root@localhost:" | awk -F ": " '{print $NF}'`
     rm -f /root/passwordinfo.txt

     echo "first_old_password=$first_old_password"
     echo "second_old_password=$second_old_password"
     echo "third_old_password=$third_old_password"
     #echo "one=$first_old_password">>/root/passwordinfo.txt
     #echo "two=$second_old_password">>/root/passwordinfo.txt
     #echo "three=$third_old_password">>/root/passwordinfo.txt
}


#8.开启各实例的SSL连接
open_mysql_instance_SSL(){
	/usr/local/mysql/bin/mysql_ssl_rsa_setup --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql_3306
    [ $? -eq 0 ] && echo init mysql_3306 SSL successful. || echo init mysql_3306 SSL error.

	/usr/local/mysql/bin/mysql_ssl_rsa_setup --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql_3307
    [ $? -eq 0 ] && echo init mysql_3307 SSL successful. || echo init mysql_3307 SSL error.
    
	/usr/local/mysql/bin/mysql_ssl_rsa_setup --user=mysql --basedir=/usr/local/mysql --datadir=/data/mysql_3308
    [ $? -eq 0 ] && echo init mysql_3308 SSL successful. || echo init mysql_3308 SSL error.

}


#9.设置环境变量等操作
last_setup(){
    #复制多实例脚本到服务管理目录下
    cp  /usr/local/mysql/support-files/mysqld_multi.server /etc/init.d/mysqld_multi
    
    #给予脚本可执行权限
    chmod +x /etc/init.d/mysqld_multi
    
    #加入service服务管理
    chkconfig --add mysqld_multi
    
    #添加环境变量
    echo "export MYSQL_HOME=/usr/local/mysql">>/etc/profile
    echo  -e "export PATH=\${MYSQL_HOME}/bin:\$PATH">>/etc/profile
    sleep 2 
    #使修改的配置文件生效
    source /etc/profile
    source /etc/profile
}

#10.启动mysql多实例
start_mysql_instance(){
    #启动mysql多实例
    /etc/init.d/mysqld_multi    start
    sleep 2
    #检测实例是否启动成功
    if [ `ss -tulpn|grep mysqld|wc -l`   -eq 3  ]
        then
            echo "start mysql instance successful."
    else
            echo "start mysql instance error."
            exit 3
    fi
}

#11.修改mysql多实例密码,以及设置允许远程连接
change_mysql_instance_password(){
    #组织修改默认密码命令
    set_password_cmd=`echo "alter user 'root'@'localhost' identified by 'newpassword';"|sed -n "s/newpassword/$new_password/p"`
    echo "set_password_cmd=$set_password_cmd"
   
    #组织设置设置允许远程连接命令
    set_remote_cmd=`echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION;FLUSH PRIVILEGES;"|sed -n "s/password/$new_password/p"`
    echo "set_remote_cmd=$set_remote_cmd"
    
    echo "first_old_password=$first_old_password"
    echo "second_old_password=$second_old_password"
    echo "third_old_password=$third_old_password"

    #读取保存的实例的默认密码
    #first_old_password=`cat /root/passwordinfo.txt|grep one|awk -F "e=" '{print $2}'`
    #second_old_password=`cat /root/passwordinfo.txt|grep two|awk -F "o=" '{print $2}'`
    #third_old_password=`cat /root/passwordinfo.txt|grep three|awk -F "e=" '{print $2}'`
    
    #修改实例mysql_3306的默认密码以及设置允许远程连接
    mysql -S  /tmp/mysql.sock1 -p$first_old_password --connect-expired-password -e"$set_password_cmd;$set_remote_cmd"
    first_flag=$?

    #修改实例mysql_3307的默认密码以及设置允许远程连接
    mysql -S  /tmp/mysql.sock2 -p$second_old_password --connect-expired-password  -e"$set_password_cmd;$set_remote_cmd"
    second_flag=$?

    #修改实例mysql_3308的默认密码以及设置允许远程连接
    mysql -S  /tmp/mysql.sock3 -p$third_old_password --connect-expired-password  -e"$set_password_cmd;$set_remote_cmd"
    third_flag=$?

    echo "first_flag = $first_flag;second_flag=$second_flag;third_flag=$third_flag"
    if [[ $first_flag == 0 ]] && [[ $second_flag == 0 ]]  && [[  $third_flag == 0  ]]
        then
            echo "change mysql instance password successful."
    else
            echo "change mysql instance password error."
            #exit 4
    fi
}

init(){
    rm -rf mysql-5.7.19-linux-glibc2.12-x86_64
    rm -rf /usr/local/mysql
    rm -rf /data
    rm -rf /etc/my.cnf
    rm -rf /root/passwordinfo.txt
}

:<<eof
#访问mysql实例指令
mysql -S /tmp/mysql.sock1 -p密码
#查看监听的端口
ss -tulpn|grep mysqld
#启动mysql多实例指令
mysqld_multi start
#查看实例运行状态
mysqld_multi report
#停止多实例运行
killall mysqld

eof
main(){
    init
    #1.获取mysql安装文件[9]
    get_mysql_install_file $1 $2
    #2.关闭SELinux[19]
    close_SELinux
    #3.关闭防火墙[37]
    close_firewall
    #4.安装mysql[55]
    install_mysql
    #5.配置mysql多实例[72]
    add_mysql_multi_instance
    #6.配置mysql的配置文件/etc/my.cnf[88]
    set_mycnf_file
    #7.初始化各实例并保存密码到文件/root/mysql_old_password.txt[150]
    init_mysql_instance
    #8.开启各实例的SSL连接
    open_mysql_instance_SSL
    #9.设置环境变量等操作
    last_setup
    #10.启动mysql多实例服务
    start_mysql_instance
    #11.修改mysql多实例密码
    change_mysql_instance_password
}

main $# $1






