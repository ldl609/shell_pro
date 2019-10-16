#!/bin/bash
# chkconfig: 2345 20 80
# description:Saves and restores system entropy pool

:<<eof
1.实现脚本开机自启动,需要使用chkconfig命令来实现
<1>首先要在脚本的的开头解释器之后加入以下两行包含#
 a."2345"为linux运行级别,20为脚本的开始启动顺序,80为脚本的停止顺序
 b.应用服务一般要靠后启动为佳,越早停止越好
# chkconfig: 2345 20 80
# description:Saves and restores system entropy pool

<2>设置开机启动操作
 a.脚本一定要放在/etc/init.d/目录下
 b.然后执行以下命令
 chkconfig --add  test.sh
 c.检查自启动结果
 chkconfig --list  test.sh
 d.删除自启动脚本
 chkconfig --del  test.sh
 
eof
