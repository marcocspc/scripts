#!/bin/bash

### Dependencies:
# ff_set.sh --> https://gist.github.com/marcocspc/39ae0d26760b881a828b95ffc14d4dcc

VPNINTERFACE=""
SSHTUNNELUSER=""
SSHTUNNELHOST=""

case $@ in
        "start" )
			sudo systemctl start wireguard_watchdog wg-quick@$VPNINTERFACE
			ssh -D 127.0.0.1:8888 -N -f $SSHTUNNELUSER@$SSHTUNNELHOST
			ff_set.sh network.proxy.type 1
			killall firefox 
            nohup firefox > /dev/null &
            ;;
        "stop" )
			sudo systemctl stop wireguard_watchdog wg-quick@$VPNINTERFACE
			ff_set.sh network.proxy.type 0
			killall firefox 
            nohup firefox > /dev/null &
            ;;
        "restart" )
			sudo systemctl restart wireguard_watchdog wg-quick@$VPNINTERFACE
			ssh -D 127.0.0.1:8888 -N -f $SSHTUNNELUSER@$SSHTUNNELHOST
			ff_set.sh network.proxy.type 1
			killall firefox 
            nohup firefox > /dev/null &
            ;;
esac

