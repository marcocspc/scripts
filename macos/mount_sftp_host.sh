#!/bin/bash

#Got base code from https://jonathansblog.co.uk/sshfs-mount-remote-drive-in-finder
#You must install sshfs for this to work: brew install sshfs

USER="your username"
VOLUME_NAME="Name to show on /Volumes"
KEY_PATH="/path/to/keyfile" #KEY_PATH CANNOT HAVE SPACES, FOR SOME WEIRD REASON
IP_OR_NAME="ip or name of the server"
REMOTE_ADDRESS="/path/on/server/to/mount"
PORT="22"

for i in $(seq 1 $END); do
    mkdir "/Volumes/$VOLUME_NAME$i" || echo "" 
    sshfs -o reconnect -o volname="$VOLUME_NAME" "$USER@$IP_OR_NAME":"$REMOTE_ADDRESS" "/Volumes/$VOLUME_NAME$i" -p $PORT || echo "Tried to mound /Volumes/$VOLUME_NAME$i, didn't work, trying next number."
done
