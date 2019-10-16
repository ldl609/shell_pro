#!/bin/bash
command_str=""
#获取命令可以参数传入,和手动输入
get_command(){
    if [ $1 -ne 1 ]
        then
            read -p "pls input command[start|stop|restart]:" command_str
    else
            command_str=$2
    fi
}

#执行命令来启动停止或重启rsync
run_command(){
    case $1 in
        start)
            rsync --daemon
            sleep 2
            if [ `netstat -lntup|grep rsync|wc -l` -ge 1 ]
                then
                    echo  -e "\E[1;31m rsync is started. \E[0m"
                    exit 0
            else
                    echo -e "\E[1;31m rsync start error. \E[0m"
            fi
            ;;
        stop)
            killall rsync &>/dev/null
            sleep 2
            if [ `netstat -lntup|grep rsync|wc -l` -eq 0 ]
                then
                    echo -e "\E[1;31m rsync is stoped. \E[0m"
                    exit 0
            else
                    echo -e "\E[1;31m rsync stoped error."
                    exit 1
            fi
            ;;
        restart)
            killall rsync 
            sleep 2
            killpro=`netstat  -lntup|grep rsync|wc -l`
            rsync   --daemon
            sleep 2
            startpro=`netstat  -lntup|grep rsync|wc -l`

            if [ $killpro -eq 0 -a $startpro -ge 1 ]
                then
                    echo -e "\E[1;31m rsync is restarted. \E[0m"
                    exit 0
            else
                    echo -e "\E[1;31m rsync restart error. \E[0m"
                    exit 2
            fi
            ;;
        *)
            echo -e "\E[1;31m pls input correct commands! \E[0m"
    esac
}


main(){
    while true
    do
        get_command $1 $2
        run_command $command_str
    done
}

main  $# $1


