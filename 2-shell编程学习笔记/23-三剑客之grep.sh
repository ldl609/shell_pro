#!/bin/bash

																	1.grep简述
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
<1>grep指令是一个全局查找正则表达式并且打印结果行的命令
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
<2>grep命令在一个或多个文件中查找某个字符模式.如果这个模式中包含空格,就必须用引号把它括起来
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
<3>位于模式之后所有的单词都被视为文件名
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------


																	2.grep选项说明
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	选项					功能									示例																	示例说明
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-E		后面的正则表达式就是扩展的正则表达式,也就是grep -E=egrep			grep -E "west|north" grep.txt
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-i		比较字符串时忽略大小写的区别									grep -i 'north' grep.txt				关闭大小写
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-w		把表达式作为词来查找,相当于正则中的"\<...\>"					grep -w 'north' grep.txt				只查找作为一个词,而不是词的一部分出现的模式	
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-l		只输出包含模式的文件名,而不输出文本行(在查找多个文件时)			grep -l 'SE*'  sed.txt grep.txt
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-x		被匹配到的内容,正好是整个行,相当于正则"^...$"					grep -x 'exit 0' grep.sh 				只匹配以"exit 0"为整行内容的行
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-v		取反,也就是输出我们定义模式相反的内容(不包含选项的行)				grep -v 'north' grep.txt				匹配不包含'north'的行
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-c		count.统计,统计匹配结果的行数,不是匹配结果的次数是行数			grep -c 'north' grep.txt				匹配到结果的行数
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-m		只查找作为一个系,而不是词的一部分出现的模式	
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-n		在输出的结果里显示行号,这里的行号是在原文件中的行,不是结果中的行	grep -n 'north' grep.txt				找到指定的模式行的行前加上行号
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-o		只显示匹配内容,默认显示满足匹配条件的一行内容	
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-R		递归匹配,如果要在一个目录多个文件中匹配则需要这个参数
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-B		输出满足条件的前几行											grep -B 2 'exit 0' grep.sh				匹配内容并打印匹配到内容的前两行
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-A		输出满足条件的后几行											grep -A 2 'exit 0' grep.sh				匹配内容并打印匹配到内容的后两行
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 	-C		相当于同时用-B -A,也就是前后都输出								grep -A 2 'exit 0' grep.sh				匹配内容并打印匹配到内容的前两行以及后两行的内容
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------

































