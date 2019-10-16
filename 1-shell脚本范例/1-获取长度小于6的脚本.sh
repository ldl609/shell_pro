#!/bin/bash
len=$#
echo "len = $len"
if [ $len -ne 6 ]
    then
        echo "请输入6个参数!"
        exit 1
fi

string[0]=$1;string[1]=$2;string[2]=$3;string[3]=$4;string[4]=$5;string[5]=$6

for((i=0;i<${#string[*]};i++))
do
    if [ ${#string[i]} -lt 4 ]
        then
            echo ${string[i]}
    fi
done

