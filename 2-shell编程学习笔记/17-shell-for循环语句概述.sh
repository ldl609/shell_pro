#!/bin/bash


1.第一种语法
 for 变量名  in  变量取值列表
 do
	指令...
 done
 
示例:1
for n  in  {1..25}
do
	echo $n
done

示例:2
for n  in  {a..z}
do
	echo $n
done

示例:3
for n  in  23 4455 789 56
do
	echo $n
done


2.第二种语法
 for((i=0; i<10;i++))
 do
	指令...
 done

示例:1
for((i=1;i<10;i++))
do
	echo $i
done
