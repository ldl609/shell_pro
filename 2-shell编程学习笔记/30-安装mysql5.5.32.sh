
#1.创建mysql用户的账号
groupadd mysql
useradd -s /sbin/nologin -g  mysql -M  mysql

#2.首先现在mysql二进制安装包
wget	http://dev.mysql.com/get/Downloads/MySQL-5.5/mysql-5.5.32-linux2.6-x86_64.tar.gz

#3.解压安装包
tar -zxvf  mysql-5.5.32-linux2.6-x86_64.tar.gz

#4.移动解压后的安装包文件到指定安装目录(/usr/local/mysql)
cd mysql-5.5.32-linux2.6-x86_64
mkdir /usr/local/mysql
mv *  /usr/local/mysql

#5.初始化mysql配置文件my.cnf
cp	/usr/local/mysql/support-files/my-small.cnf	  /etc/my.cnf

#6.初始化mysql数据库文件
mkdir -p /usr/local/mysql/data
chown -R  mysql.mysql /usr/local/mysql/
/usr/local/mysql/scripts/mysql_install_db  --basedir=/usr/local/mysql/  --datadir=/usr/local/mysql/data/  --user=mysql

#7.设置mysql启动脚本
cp	/usr/local/mysql/support-files/mysql.server   /etc/init.d/mysqld
chmod +x	/etc/init.d/mysqld

#8.启动mysql
/etc/init.d/mysqld   start

#9.检查数据库是否启动成功
netstat -lntup|grep  mysql

#10.设置mysql开机自启动
chkconfig --add mysqld 
chkconfig  mysqld  on
chkconfig --list mysqld

#11.配置mysql命令的全局使用路径(修改/etc/profile)
export  PATH=/usr/local/mysql/bin:$PATH
#修改保存后执行以下指令
source  /etc/profile

#12.登录mysql修改登录密码
#命令行输入
mysql
#进入mysql后执行以下指令修改密码
mysqladmin -u  root password '123456'

#13.至此mysql安装设置完成









