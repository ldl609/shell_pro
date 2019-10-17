#!/bin/bash

new_password=""
#获取mysql新密码,由于需要重置密码才能使用所以
get_new_password(){
	
	if [ $1 -eq 0 ]
		then
			read -p "pls input new password:" new_password
			
	else
			new_password=$2
	fi
	
	#当密码少于6个字符时继续获取
	if [ ${#new_password} -lt 6 ]
		then
			echo -e "\E[1;31m Password must be more than six characters,pls input again! \E[0m"
			get_new_password 0 0
	fi
}

get_new_password $# $1
echo -e "new password is \E[1;31m$new_password\E[0m,pls remember the password"

# 1.首先下载安装Yum Repository(yum存储库)
wget -i -c http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
yum -y install mysql57-community-release-el7-10.noarch.rpm
# 检测安装Yum Repository是否成功安装
if [ $? -eq 0 ]
	then
		echo -e "\E[1;31m Successful installation of Yum Repository! \E[0m" 
else
		echo -e "\E[1;31m Error installing Yum Repository! \E[0m"
		exit 1
fi


# 2.安装mySQL服务器
yum -y install mysql-community-server

if [ $? -eq 0 ]
	then
		echo -e "\E[1;31m Successful installation of mysql! \E[0m" 
else
		echo -e "\E[1;31m Error installing mysql! \E[0m"
		exit 2
fi

#3.启动mysql
systemctl start  mysqld.service
if [ `systemctl status mysqld.service|grep "active (running)"|wc -l` -gt 0 ]
	then
		echo -e "\E[1;31m start mysql successful! \E[0m"
else
		echo -e "\E[1;31m start mysql error! \E[0m"
		exit 3
fi

#4.获取数据库初始密码
old_password=`grep "password.*root@localhost:" /var/log/mysqld.log | awk -F ":" '{print $NF}'`
echo -e "\E[1;31m Initial password is:$old_password \E[0m"

#5.登录mysql修改初始密码
# 用于修改配置文件设置密码规范就可以设置相对简单的密码了ca
mysql -uroot -p$old_password -e"set global validate_password_policy=0;"
mysql -uroot -p$old_password -e"set global validate_password_length=1;"

# -e参数后用于修改密码
new_password_cmd=`echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'newpswd';"|sed -n "s/newpswd/$new_password/p"`
mysql -uroot -p$old_password -e"$new_password_cmd"


if [ $? -eq 0 ]
	then
		echo -e "\E[1;31m Successful password modification! \E[0m" 
else
		echo -e "\E[1;31m Failed to change password! \E[0m"
		exit 4
fi

# 6.最后卸载掉Yum Repository以防止每次yum操作都会自动更新
yum -y remove mysql57-community-release-el7-10.noarch

#7.删除下载的安装文件
rm -f mysql57-community-release-el7-10.noarch.rpm

# 8.提示安装完成
echo  -e "\E[1;31;43m Successful installation of MySQL! \E[0m"



