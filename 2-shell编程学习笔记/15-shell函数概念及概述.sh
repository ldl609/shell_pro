#!/bin/bash

:<<eof
 1.shell函数语法
 <1>标准写法
 function 函数名() {
 		指令.....
 		return n
 }

 <2>简化写法1
 函数名后无括号
 function 函数名 {
 		指令.....
 		return n
 }

 <3>简化写法2
 不用function关键字
 函数名 (){
 		指令.....
 		return n
 }
 ----------------------分割线---------------------------------------

 2.shell不带参数函数的执行
 <1>执行函数时,函数名前的function和小括号都不要带
 <2>函数的定义必须在执行之前定义或加载
 <3>shell执行系统各种程序的执行顺序为:系统别名->函数->系统命令->可执行文件
 <4>函数执行时,会调用它的脚本公用变量,也可以为函数设定局部变量及特殊位置参数
 <5>shell函数里return的作用是退出函数,exit是退出脚本
 <6>return会返回一个返回值给调用函数的当前程序,而exit会返回一个退出值给执行程序的当前Shell
 <7>如果函数存放在独立的文件中,被脚本夹在使用时,需要使用source或'.'来加载
 <8>在函数类=内一般使用local定义局部变量,这些变量离开函数后就会消失

 示例
 在分离函数体和函数执行脚本方法示例
 首先在functions.sh中定义函数myname如下:
 #!/bin/bash
 myname(){
 		echo "my name is ldl"
 }

 然后在执行函数脚本test.sh中添加如下代码:
 #!/bin/bash
 source functions.sh	#加载外部函数
 getmyage(){
 		echo "26"
 }
 myname
 getmyage
 -----------------------分割线---------------------------------------


 3.shell带参数函数的执行(函数名 参数1 参数2)
 <1>shell的位置参数($1,$2...,$#,$*)都可以作为函数的参数来使用
 <2>此时福脚本的参数临时的被函数参数所掩盖或隐藏
 <3>当函数执行完成时,原来的命令行脚本的参数也即可恢复
 <4>函数的参数变碧昂是在函数体里面定义的

 示例
 首先在functions.sh中定义函数myname如下:
 #!/bin/bash
 myname(){
 		echo "my name is $1"
 }

 然后在执行函数脚本test.sh中添加如下代码:
 #!/bin/bash
 source functions.sh		#加载外部函数
 getmyage(){
 		echo $1
 }

 myname  "liudongling"
 getmyage "29"

 myname  $1
 getmyage $2

eof



