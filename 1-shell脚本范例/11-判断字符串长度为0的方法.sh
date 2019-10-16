#!/bin/bash
#1.使用条件表达式实现判断字符串
test_str="linux"
# -z选项判断字符串长度是否为0,为0时为真
[ -z  $test_str ] && echo true || echo fasle
# -n选项判断字符串长度非0,当长度大于0时为真
[ -n $test_str ] && echo true || echo false

#2.使用变量子串判断方法,大于0时为真
[ ${#test_str} -gt 0 ] && echo true || echo false

#3.使用expr命令的函数lenth来判断
[ `expr length $test_str` -gt 0 ] && echo true|| echo  fasle

#4.使用wc -L 参数判断
[ `echo $test_str|wc -L` -gt 0 ] &&echo true || echo false

#使用awk length函数来实现
[  `echo $test_str|awk '{print length}'` -gt 0 ] && echo true || echo false




