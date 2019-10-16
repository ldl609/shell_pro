#!/bin/bash

:<<eof
 1.单分支结构
 <1>第一种语法
 if 条件表达式
   then
       指令
 fi
 
 <2>第二种语法
 if 条件表达式; then
 	 指令...
 fi
 
 嵌套
 if 条件表达式
   then
       if 条件表达式
          then
             指令...
		fi
 fi
 ------------------end----------------------------------------------
 
 2.双分支结构
 if 条件表达式
   then
		指令...
 else
		指令...
 fi
 ------------------end----------------------------------------------

 3.多分支结构
 每个elif必须带有then
 if 条件表达式
   then
       指令...
 elif
	then
		指令...
 else
		指令...
 fi
 ------------------end--------------------------------------------

 4.多elif结构
 if
   then
       指令...
 elif
	then
		指令...
 elif
	then
		指令...
 else
		指令...
 fi 

eof
