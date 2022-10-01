#!/bin/sh
set -e
HOSTINFO=$(/usr/bin/lsb_release -a 2>&1 | grep Description | /usr/bin/cut -d ":" -f2 | /usr/bin/tr -d [:blank:])
IPADDRS=$(/usr/sbin/ip -4 -br a)
/usr/bin/echo -ne "Host OS: $HOSTINFO\n\l\n$IPADDRS\n" > /etc/issue
