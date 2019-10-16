#!/bin/bash
# chkconfig: 2345 23 80
# description:Saves and restores system entropy pool
# 实现Apache服务启动脚本
HTTPD_LANG=${HTTPD_LANG:-"C"}
INITLOG_ARGS=""
apchectl=/usr/sbin/apachectl
httpd=${HTTPD:-/usr/sbin/httpd}
prog=httpd
pidfile=${PIDFILE:-/var/run/http.pid}
lockfile=${LOCKFILE:-/var/lock/sunsys/httpd}

