#!/bin/bash

#Got base code from https://jonathansblog.co.uk/sshfs-mount-remote-drive-in-finder

VOLUME_NAME="Name to show on /Volumes"
KEY_PATH="/path/to/keyfile"
IP_OR_NAME="ip or name of the server"
REMOTE_ADDRESS="/path/on/server/to/mount"

sshfs -o reconnect -o volname=$VOLUME_NAME -o IdentityFile=$KEY_PATH $IP_OR_NAME:$REMOTE_ADDRESS /Volumes/$VOLUME_NAME
