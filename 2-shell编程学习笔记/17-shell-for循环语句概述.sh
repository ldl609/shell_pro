#!/bin/bash

:<<eof
 1.第一种语法
 for 变量名  in  变量取值列表
 do
	指令...
 done
 
eof
for n  in  {1..25}
do
	echo $n
done

for n  in  {a..z}
do
	echo $n
done


for n  in  23 4455 789 56
do
	echo $n
done

:<<eof
 2.第二种语法
 for((i=0; i<10;i++))
 do
	指令...
 done
 
eof
for((i=1;i<10;i++))
do
	echo $i
done
