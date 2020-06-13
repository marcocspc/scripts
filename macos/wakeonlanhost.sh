#!/bin/bash

#You must install wakeonlan for this to work: brew install wakeonlan

LAN_BROADCAST_ADDRESS=""
PC_MAC_ADDRESS=""

wakeonlan -i $LAN_BROADCAST_ADDRESS -p 7 $PC_MAC_ADDRESS
