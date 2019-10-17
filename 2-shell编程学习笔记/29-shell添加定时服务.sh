#!/bin/bash

1.cron服务的启动停止以及状态指令
 <1>启动cron服务
 systemctl start crond
 <2>停止cron服务
 systemctl stop crond
 <3>查看cron服务状态
 systemctl status crond
 <4>设置cron服务开机启动
 systemctl enable crond.service
 
2.cron服务配置文件为/etc/crontab
3.任务添加格式
*		*		*		*		*		command
分		时		日  	月  	周		  指令
第一列表示分钟1-59 (每分钟用*或者*/1表示)
第二列表示小时0-59 (0表示0点每小时用*或者*/1表示)
第三列表示日期1-31 (10,15,27用逗号隔开表示这一项选择多项)
第四列表示月份1-12
第五列表示星期0-6 (0表示星期天)
第六列表示要执行的命令

4.示例添加定时同步时间(root表示执行的用户)
#表示每分钟同步一次
echo '*/1	*	*	*	*	root	/usr/bin/rdate -s -u time.nist.gov'>>/etc/crontab
#表示每3小时同步一次
echo '*	 */3	*	*	*	root	/usr/bin/rdate -s -u time.nist.gov'>>/etc/crontab
#表示每天的12点45分同步
echo '45	12	*	*	*	root	/usr/bin/rdate -s -u time.nist.gov'>>/etc/crontab
#表示每个星期6晚上11点同步
echo '0	23	*	*	6	root	/usr/bin/rdate -s -u time.nist.gov'>>/etc/crontab
#表示每天12点到19点之间每隔30分钟同步一次
echo '0,30	12-19	*	*	*	root	/usr/bin/rdate -s -u time.nist.gov'>>/etc/crontab
#表示每天12点到19点之间每隔1小时同步一次
echo '*	12-19/1	*	*	*	root	/usr/bin/rdate -s -u time.nist.gov'>>/etc/crontab
