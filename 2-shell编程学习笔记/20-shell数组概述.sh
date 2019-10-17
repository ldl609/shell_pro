#!/bin/bash
:<<eof
1.数组定义方式1
 每个值要用空格分隔 *号可用@代替
eof
ayyay=(12 wdw 98 df 12 23)
echo ${array[*]} #输出数组的所有元素值
echo ${array[@]} #输出数组的所有元素值

echo ${#array[*]} #输出数组元素个数

array[6]=ldl	#数组赋值
array[2]=lhy	#修改数组元素

echo ${array[*]:1:3} #取数组下标1到3号的数组元素

echo ${array[*]/12/b} #将数组中的12替换为b

echo ${ayyay[*]#o*}	#从左边开始匹配最短的数组元素并删除
echo ${ayyay[*]##o*} #从左边开始匹配最长的数组元素并删除

echo ${ayyay[*]%f*}	#从右边开始匹配最短的数组元素并删除
echo ${ayyay[*]%%f*} #从右边开始匹配最短的数组元素并删除

unset array[1]  #取消删除下标为1的数组元素
unset array		#删除整个数组

:<<eof
2.数组定义方式2
 每个值要用空格分隔
eof
ayyay=([0]=12 [1]=wdw [2]=98 [3]=df [4]=e12)

echo ${array[*]} #输出数组的所有元素值
echo ${array[1]} #输出数组的第一个元素

:<<eof
3.数组定义方式3
eof
ayyay[0]=12;ayyay[1]=wdw;ayyay[2]=98;ayyay[3]=df;ayyay[4]=e12)

echo ${array[*]} #输出数组的所有元素值
echo ${array[0]} #输出数组的第一个元素

:<<eof
4.数组定义方式4
动态定义数组 ayyay($(`命令`)) 或 ayyay($(命令))
eof
ayyay($(ls /etc))
echo ${array[*]} #输出数组的所有元素值
echo ${array[0]} #输出数组的第一个元素

echo "------------------------FGX----------------------"

# 通过for打印数组元素
ay($(`ls /etc`))
for((i=0;i<${#ay[*]};i++))
do
	echo "$i = ${ay[i]}"
done

for n in ${ay[*]}
do
	echo $n
done





























