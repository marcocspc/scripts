#!/bin/bash

#Put this script to run in cron

#This variable should store your configuration name without .conf
#For example, for wg0.conf this variable should store wg0
FILENAME_WITHOUT_DOTCONF=
#Your server IP inside the VPN, usually 10.0.0.1
SERVER_WG_IP=

tries=0
while [[ $tries -lt 3 ]]
do
        if /bin/ping -c 1 $SERVER_WG_IP
        then
#               echo "wg working"
                logger -n $HOSTNAME -i -t "wg-watchdog" -p user.notice "wireguard working"
                exit 0
        fi
#      echo "wg fail"
        tries=$((tries+1))
done
#echo "restarting wg"
sudo systemctl restart wg-quick@$FILENAME_WITHOUT_DOTCONF
logger -n $HOSTNAME -i -t "wg-watchdog" -p user.notice "wireguard restarted"

