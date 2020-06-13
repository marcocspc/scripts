#!/bin/bash

#Got base code from https://jonathansblog.co.uk/sshfs-mount-remote-drive-in-finder
#You must install sshfs for this to work: brew install sshfs

USER="your username"
VOLUME_NAME="Name to show on /Volumes"
KEY_PATH="/path/to/keyfile" #KEY_PATH CANNOT HAVE SPACES, FOR SOME WEIRD REASON
IP_OR_NAME="ip or name of the server"
REMOTE_ADDRESS="/path/on/server/to/mount"

mkdir "/Volumes/$VOLUME_NAME"
sshfs -o reconnect -o volname="$VOLUME_NAME" -o IdentityFile="$KEY_PATH" "$USER@$IP_OR_NAME":"$REMOTE_ADDRESS" "/Volumes/$VOLUME_NAME"
