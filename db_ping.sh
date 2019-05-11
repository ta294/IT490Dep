#!/bin/bash
set -x

#Host is master database
HOST=192.168.1.5
ping -c1 $HOST 1>/dev/null 2>/dev/null
SUCCESS=$?

if [ $SUCCESS -eq 0 ]
then
        echo "$HOST has replied"
else
        echo "$HOST didn't reply"

       #`./chkconnection.sh`
       ifconfig enp0s9 192.168.1.5 netmask 255.255.255.0 up
       systemctl start 490sysd

fi
#EOF

