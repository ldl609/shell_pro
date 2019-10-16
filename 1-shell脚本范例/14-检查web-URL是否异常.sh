#!/bin/bash

url_str=""
get_url(){
    if [ $1 -ne 1 ]
        then
            read -p "pls input URL:"  url_str
    else
            url_str=$2
    fi
}

test_url(){
    wget --spider -q -o /dev/null --tries=1 -T 5 $url_str
    if [ $? -eq 0 ]
        then
            echo -e "\E[1;31m $url_str is yes.\E[0m"
    else
            echo -e "\E[1;31m $url_str is error. \E[0m"
    fi
}

main(){
    get_url $1 $2
    test_url
}

main $# $1
