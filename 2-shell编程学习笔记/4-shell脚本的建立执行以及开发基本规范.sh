

							Shell脚本开发规范

#-----------------------------------------------------------------------
1.shell脚本的建立
-通常在vim中编写
-由UNIX/linux命令,bash shell命令,程序结构控制语句等类容组成

#-----------------------------------------------------------------------
2.脚本的开头
-一个规范的Shell脚本在第一行会指出由哪个解释器来执行脚本内容
-这一行在linux bash的编程一般为
-这一行必须在每个脚本的顶端的第一行,否则脚本的注释行
 #!/bin/bash
 或
 #!/bin/sh

#-----------------------------------------------------------------------
3.脚本注释
-在shell脚本中一般采用用#表示注释
-多行注释
:<<eof
	指令.....
eof	

#-----------------------------------------------------------------------
4.shell脚本的执行(4大类方法)
-bash test.sh 或 sh test.sh (推荐使用此方法)
  <1>这是脚本文件没有可执行权限的常用方法
  <2>脚本文件开头没有指定解释器时须使用的方法
  
-/root/shell_work/test.sh 或 ./test.sh
 <1>脚本文件必须指定解释器
 <2>必须保证脚本文件的权限为可执行(+x)
 <3>然后脚本的绝对路径或相对路径就可以直接执行脚本了
 
-source test.sh 或 . test.sh
 <1>加载并执行相关脚本的命令及语句,而不是产生一个子Shell来执行文件中的命令
 <2>注意'.'和后面的脚本文件名要有空格隔开
 
-sh<test.sh 或 cat test.sh|sh


#----------------------------------------------------------------------
5.shell脚本高级命名规范
a.常规脚本统一使用统一的后缀
b.模块的启动和停止脚本同一命名为start_模块名.sh和stop_模块名.sh
c.监控脚本通常以mon_*.sh为后缀
d.控制脚本通常以ctl_*.sh为后缀




