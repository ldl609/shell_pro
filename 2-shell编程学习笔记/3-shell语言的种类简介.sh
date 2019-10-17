:<<eof

							shell脚本语言的种类
#-----------------------------------------------------------------------
1.Bourne shell
-Bourne shell(sh)
 <1>由AT&T的Stev Bourne开发
 <2>是标准的UNIX Shell
 <3>很多UNIX系统都配有sh
 
-Korn shell(Ksh)
 <1>由David Korn开发
 <2>是sh的超集合
 <3>是目前很多UNIX系统标准配置的Shell
 <4>这些系统上的/bin/sh往往是指向/bin/ksh的符号链接
 
-Bourne Again Shell(bash)
 <1>由GNU项目组开发,主要目标是与POSIX标准保持一致同时兼顾对sh的兼容
 <2>是各种linux发型版本默认的shell
 <3>linux系统上的/bin/sh往往是指向/bin/bash的符号链接

#-----------------------------------------------------------------------
2.C shell
-csh
 <1>由Berkeley大学开发
 <2>流程控制语句很想C语言
 <3>支持很多sh所不支持的功能

-tcsh
 <1>是csh的增强版,加入了命令补全功能
 <2>在FreeBSD,Mac os X等系统上替代了csh
 <3>支持很多sh所不支持的功能

.linux系统主流Shell是bash,bash是由sh发展而来,同时还包含了csh和ksh的特色

#-----------------------------------------------------------------------
3.其他脚本语言
-PHP(很少使用)
-Perl(已成为历史)
-python(较常用,发展趋势良好需掌握)

eof
