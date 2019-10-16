#!/bin/bash

#1.配置国内高速yum源
change_yum_source(){
    #先备份原来的文件
    mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup
    #下载国内高速yum源
    wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
    
    if [ $? -eq 0 ]
        then
            echo -e "\E[1;31m change yum source successful. \E[0m"
    else
            echo -e "\E[1;31m change yum source error. \E[0m"
    fi
            
}

#2.关闭SELinux
close_SELinux(){
    #直接修改文件/etc/selinux/config的内容
    sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
    #设置当前不启用selinux
    setenforce 0
    #查看selinux状态
    status=`getenforce`
    if [[ "$status" == "Permissive" ]]
        then
            echo -e "\E[1;31m closs SELinux successful. \E[0m"
    else
            echo -e "\E[1;31m closs SELiuunx Error.\E[0m"
    fi
}

#3.关闭防火墙
close_iptables(){
    #适用于centos6
    iptables stop
    iptables stop
    chkconfig iptables off
}

#4.精简开机自启动服务
simple_boot_service(){
    #首先把所有的启动项都关闭,取每行的第一个字段然后执行关闭指令
    chkconfig|awk '{print "chkconfig",$1,"off"}'|bash
    #然后把需要开启的项执行开启,执行开启命令
    chkconfig|grep -E "crond|sshd|network|rsyslog|sysstat"|wak '{print "chkconfig",$1,"on"}'|bash
}

#5.添加用户
add_user(){
    #首先检测设置的用户名ldl609是否已经存在
    if [ `grep -w "ldl609" /etc/password|wc -l` -lt 1 ]
        then
            #创建用户ldl609
            useradd  ldl609
            #设置ldl609用户密码
            echo 123456|passwd --stdin ldl609
            #备份sudoers文件
            cp /etc/sudoers /etc/sudoers.ori
            #添加用户sudo权限
            echo "ldl609 ALL=(ALL) NOPASSWD: ALL " >>/etc/sudoers
            #查看是否修改成功
            tail -1 /etc/sudoers
    else
            echo "user already exits."
    fi
}

set_system_char(){
    #6.设置系统字符编码
    echo 'LANG="zh_CN.UTF-8"' >/etc/sysconfig/il8n
    source /etc/sysconfig/il8n
}

set_time_sync(){
    #7.设置系统时间同步
    cron=/etc/crontab
    if [ `grep -w "ntpdate" $cron|wc -l` -lt 1 ]
        then
            #需要提前安装好rdatey以及xinetd
            #yum install -y rdate xinetd
            #把/etc/xinetd.d/time-stream中的disable = yes修改为no
            #启动以及添加开机启动xinetd;systemctl start xinetd;systemctl enable xinetd
            #需要指定执行用户这里用root用户执行,其他用户则指定其他用户名
            #以下命令为每1分钟执行一次
            echo '*/1 * * * *  root   /usr/bin/rdate -s -u time.nist.gov' >>$cron
            #可查看/etc/crontab是否添加成功
            crontab -l
    fi
}

#8.添加环境变量(这里仅作示范)
set_com_line(){
    if  [ `egrep "TMOUT|HISTSIZE|ISTFILESIZE" /etc/profile|wc -l` -lt 3 ]
        then
            echo 'export TMOUT=300' >>/etc/profile
            echo 'export HISTSIZE=5' >>/etc/profile
            echo 'export HISTFILESIZE=5' >>/etc/profile
            ./etc/profile
    fi
}

#9.增加系统文件描述符
increase_openfile(){
    if [ `grep 65535 /etc/security/limits.conf|wc -l` -lt 1 ]
        then
            echo '*             -       nofile          65535' >>/etc/securiti/limits.conf
            tail    -1  /etc/security/limits.conf
    fi
}

#10.优化kernel 参数
set_kernel(){
    if [ `grep kernel_flag  /etc/sysctl.conf|wc -l` -lt 1 ]
        then
            cat >>/etc/sysctl.conf<<EOF
            net.ipv4.tcp_fin_timeout=2
            net.ipv4.tcp_tw_reuse=1
            net.ipv4.tcp_tw_recycle=1
            net.ipv4.tcp_syncookies=1
            net.ipv4.tcp_keepalive_time=600
            net.ipv4.ip_local_port_range=4000   65000
            net.ipv4.tcp_max_syn_backlog=16384
            net.ipv4.tcp_max_tw_buckets=36000
            net.ipv4.route.gc_timeout=100
            net.ipv4.tcp_syn_retries=1
            net.ipv4.tcp_synack_retries=1
            net.core.somaxconn=16384
            net.core.netdev_max_backlog=16384
            net.ipv4.tcp_max_orphans=16384
            net.nf_conntrack_max=25000000
            net.netfilter.nf_conntrack_tcp_timeout_established=180
            net.netfilter.nf_conntrack_max=25000000
            net.netfilter.nf_conntrack_tcp_timeout_time_wait=120
            net.netfilter.nf_conntrack_tcp_timeout_close_wait=60
            net.netfilter.nf_conntrack_tcp_timeout_fin_wait=120

EOF
            sysctl -p
    fi
}

#11.初始化SSH
init_SSH(){
    cp /etc/ssh/sshd_config /etc/ssh/sshd_config.`date +"%Y-%m-%d_%H-%M-%S"`
    sed -i 's%PermitRootLogin yes%PermitRootLogin no%'  /etc/ssh/sshd_config
    sed -i 's%PermitEmptypasswords yes%PermitEmptypasswords no%'  /etc/ssh/sshd_config
    sed -i 's%UseDNS yes%UseDNS no%'    /etc/ssh/sshd_config
    /usr/sbin/sshd    reload &>/dev/null
}

#12.更新linux
updata_linux(){
    if [ `rpm -ga lrzsz nmap tree dos2unix nc|wc  -l` -le 3 ]
        then
            yum install lrzsz namp tree dos2unix nc -y
    fi
}

main(){
    cat<<EOF
    请输入需要执行的指令输入方括号内的数字代表执行对应的功能:
    1.配置国内高速yum源[1]
    2.关闭SELinux[2]
    3.关闭防火墙[3]
    4.精简开机启动项[4]
    5.添加并初始化用户[5]
    6.设置系统字符编码[6]
    7.设置系统时间定时同步[7]
    8.添加系统环境变量[8]
    9.增加系统文件描述符[9]
    10.优化内核参数[10]
    11.初始化SSH[11]
    12.更新linux[12]
EOF

    read -p "pls input cmd num:"  command_num

    case $command_num in 
        1)
            change_yum_source;;
        2)
            close_SELinux;;
        3)
            close_iptables;;
        4)
            simp_boot_service;;
        5)
            add_user;;
        6)
            set_system_char ;;
        7)
            set_time_sync;;
        8)
            set_com_line;;
        9)
            increase_openfile;;
        10)
            set_keenel;;
        11)
            init_SSH;;
        12)
            updata_linux;;
        *)
            echo  'pls input[1-12]'
    esac
}


main

























