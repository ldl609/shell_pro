#!/bin/bash

:<<eof
								Shell常用算术运算符
 -----------------------------------------------------------------------
  算术运算符							含义(*表示常用)
 -----------------------------------------------------------------------
	+, -						分别为加法减法 *
 -----------------------------------------------------------------------
	*, /, %						分别为乘法,除法,取余 *
 -----------------------------------------------------------------------
	**							冥运算 *
 -----------------------------------------------------------------------
	++, --						增加及减少,可前置可后置 *
 -----------------------------------------------------------------------
	!, &&, ||					逻辑非(取反),逻辑与(and),逻辑或(or) *
 -----------------------------------------------------------------------
	<, <=, >, >=				比较符号(小于,小于等于,大于,大于等于) 
 -----------------------------------------------------------------------
	==, !=, =					比较符号(相等,不相等,对于字符串'='也可表示等于)
 -----------------------------------------------------------------------
	<<, >>						向左移位,向右移位
 -----------------------------------------------------------------------
	~, |, &, ^					按位取反,按位异或,按位与,按位或
 -----------------------------------------------------------------------
	=, +=, -=, *=, /=, %=		赋值运算符,例如:a+=1,a-=1,a*=2,a/=3,a%=3
 -----------------------------------------------------------------------


								Shell常用的算数运算命令
 --------------------------------------------------------------------------------------------------------------------
  运算指令	|	  		 含义		|			示例											示例说明
			|						|
 -----------|-----------------------|---------------------------------------------------------------------------------
  (())		| 用于整数运算的常用运算,	| ((i=i+1))									运算后赋值法,即将i+1的结果赋值给变量i
			| 效率很高				| i=$((i+1))								在(())前加$表示将表达式运算结果赋值给i
			|						| ((8>7&&5==5))								可以进行比较操作,还可体验加入逻辑与和逻
			|						| echo $((2+1))								辑或用于条件判断要直接打印运算结果时在
			|						|											前面加$符
 -----------|-----------------------|---------------------------------------------------------------------------------
  let		| 用于整数运算,类似于(())	| a=10 b=23									若不加let指令则a最后的值为"a+b",加上let
			|						| let a=a+b									指令后就是计算a+b的值了
 -----------|-----------------------|---------------------------------------------------------------------------------
  expr		| 可用于整数运算,但还有很	| expr 8 + 9;expr 8 \* 9;expr 6 / 3			-数字与运算符要加空格,乘法要加'\'来转义
			| 多其他功能				| i=9;expr $i + 6							-配合变量计算
			|						| expr $i + 6 &>/dev/null;echo $?			-判断变量是否为整数
			|						| expr length "teststr"						-计算字符长度
			|						| expr "$1" : ".*\.py" &>/dev/null			-断文件扩展名是否符合要求,返回真则匹配
 -----------|-----------------------|---------------------------------------------------------------------------------
  bc		| linux下的一个计算器程序	| 3+5|bc;9/3|bc								-一般计算方法
			| (适合整数和小数运算)	| "scale=3;35/13"|bc						-使用scale=3保留3位小数
			|						| i=23;$i+34|bc								-利用bc配合变量运算
			|						|
 -----------|-----------------------|---------------------------------------------------------------------------------
  $[]		| 用于整数运算			| i=9;i=$[i+6]		
			|						| echo $[2*3]
			|						| echo $[2**4]
			|						| echo $[9/3]
			|						| echo $[8%6]
 -----------|-----------------------|---------------------------------------------------------------------------------
  awk		| 既可用于整数运算也可用	| echo "7.5 9.6" |awk '{print ($1-$2)}'		-计算7.5-9.6的值
			| 于小数运算,尤其是小数	| echo "256 88" |awk '{print ($1-25)/$2}'	-计算(256-25)/88的值
			| 运算很精确				| echo "256 88" |awk '{print ($1+25)*$2}'	-计算(256+25)*88的值
 -----------|-----------------------|---------------------------------------------------------------------------------
  declare	| 定义变量值和属性-i参数可	| declare -i A=56 B=24;A=A+B   				定义之后的A与B可以直接做算术运算
			| 以用于定义整型变量做运算	|
 --------------------------------------------------------------------------------------------------------------------

eof




