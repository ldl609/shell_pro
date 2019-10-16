#!/bin/bash

:<<eof
1.在实现发送邮件之前需要安装mail以及sendmail
yum -y install mail
yum -y install sendmail

2.启动sendmail服务
 service sendmail start

3.获取发件邮箱的授权码用于登录发送邮箱
<1>163邮箱
 选择设置选项->点击客户端授权密码->开启->获取授权码
<2>qq邮箱
 主页选择设置->账户->账户安全->POP3/IMAP/SMTP/Exchange/CardDAV/CalDAV服务->生成授权码

3.若后续发送邮件出现未响应情形时使用以下方法处理
<1>打开/etc/hosts删除以下这行
 127.0.0.1 localhost localhost.localdomain localhost4 localhost4.localdomain4
<2>重启service sendmail start

4.配置/etc/mail.rc添加以下内容,密码用登录邮箱生成的授权码
set from="464492900@qq.com" 				#对方收到邮件时显示的发件人
set smtp="smtp.qq.com"						#指定第三方发送邮件的smtp服务器地址
set smtp-auth-user="464492900@qq.com" 		#发邮件的用户名
set smtp-auth-password=zisxwfzfakzhbied		#用户名对应密码,用授权码登录
set smtp-auth=login							#SMTP的认证方式默认是LOGIN,也可改为CRAM-MD5或PLAIN方式

5.发送无邮件正文的邮件
mail -s "测试邮件"  2671751255@qq.com

6.发送有邮件正文的邮件
<1>mail -s "主题"  收件地址< 文件(邮件正文.txt)
 mail -s "邮件主题"  2671751255@qq.com < /data/findyou.txt
<2>echo "邮件正文" | mail -s 邮件主题  收件地址
 echo "邮件正文内容" | mail -s "邮件主题"  2671751255@qq.com
<3>cat 邮件正文.txt | mail -s 邮件主题  收件地址 
 cat  /data/findyou.txt | mail -s "邮件主题"  2671751255@qq.com
 
7.发送带附件的邮件
<1> mail -s "主题"  -a 附件  收件地址 < 文件(邮件正文.txt) 
 mail -s "邮件主题"  -a  /root/shell_work/test.sh  2671751255@qq.com  </data/findyou.txt

eof
