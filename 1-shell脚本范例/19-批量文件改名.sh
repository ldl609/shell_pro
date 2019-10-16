#!/bin/bash
#参数传入文件夹
file_path=""

change_file_suffix(){
    #批量修改文件后缀
    for file_name in `ls $file_path`
    do
        mv $file_path$file_name `echo $file_path$file_name|cut -d . -f 1`.$1
    done
}

del_file_name_fragment(){
    #批量去掉文件名指定相同片段
    for file_name in `ls $file_path`
    do
        new_file_name=`echo $file_path$file_name|sed -n "s/$1//p"`
        mv $file_path$file_name  $new_file_name
    done

}

add_file_name_fragment(){
    #批量添加字段到文件名
    for file_name in `ls $file_path`
    do
        rename_cmd=`echo $file_path$file_name|awk -F "." '{print $0,$1"addstr."$2}'|sed -n "s/addstr/$1/p"`
        echo $rename_cmd|xargs mv
    done

}

main(){
    if [ $1 -lt 1 ]
        then
            echo "pls input file path."
            exit 1
    else
            file_path=$2
            ls $file_path
            if [ $? -ne 0 ]
                then
                    echo "file path is not exist.pls input true file path."
                    exit 2
            fi
    fi

    cat<<EOF
    请选择你要的操作
    .批量修改文件后缀名[change|1]
    .批量删除文件名的字段[del|2]
    .批量添加字段到文件名[add|3]
EOF
    read -p "pls input you choice:" flage
    echo "flage =$flage"
    case $flage in
        "change"|"1")
            read -p "pls input change suffix.such as [txt|jpg|sh]:" change_suffix
            change_file_suffix   $change_suffix
            ;;
        "del"|"2")
            read -p "pls input del filename string:" del_str
            del_file_name_fragment  $del_str
            ;;
        "add"|"3")
            read -p "pls input add filename string:" add_str
            add_file_name_fragment  $add_str
            ;;
        *)
            echo "pls input command[chnage|del|add]."
            exit 1
    esac
}


main $# $1





