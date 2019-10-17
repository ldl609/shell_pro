#!/bin/bash
echo -e "\E[1;31m 
这是一个简单的计算器脚本
根据提示依次输入数字和算术运算符
然后得出结果 \E[0m"

first_num=0
second_num=0
operator=""

get_first_num(){
    read -p "请输入第一个数字:" first_num

    expr $first_num + 1 &>/dev/null

    if [ $? -ne 0 ]
        then
            echo "请输入常规数字!"
            get_first_num
    fi
}

get_operator(){
    read -p "请输入算术运算符:" operator

    if [[ "${operator}" != "+" ]] && [[ "${operator}" != "-" ]] && [[ "${operator}" != "*" ]] && [[ "${operrator}" != "/" ]]
        then
            echo "请输入正确的算术运算符!"
            get_operator
    fi

}

get_second_num(){
    read -p "请输入第二个数字:" second_num
    expr ${second_num} + 1 &>/dev/null
    if [ $? -ne 0 ]
        then
            echo "请输入常规数字!"
            get_second_num
    fi
}

calculation(){
    echo -e "(${first_num}${operator}${second_num})结果为:\E[1;31m $((${first_num}${operator}${second_num})) \E[0m"
}

continue_calculation(){
    read -n1 -p "是否继续进行计算[y/n]" answer
    echo -e "\n"
    case $answer in
        y | Y)
            echo "继续进行计算!"
            ;;
        n | N)
            echo "退出计算程序!"
            exit 0
            ;;
        *)
            echo "请按照提示输入正确的内容!"
            continue_calculation
            ;;
    esac
}

main(){
    unset first_num
    unset second_num
    unset operator

    get_first_num
    get_operator
    get_second_num
    calculation
    continue_calculation
}

while true
do
    main
done
