#!/bin/bash

# this script creates a temporary vmdk in /tmp
# linking it to your sd card and adding it to your vm
# BTW the first parameter should be your /dev/disk and 
# the second parameter the VM name.
# also, this script will loop to keep unmounting the disk
# while you're using it. this is needed because 
# sometimes, when virtualbox is about to start the vm
# macos remounts the sd card, making the vm startup fail.

set -e

trap "undo_and_exit $1 $2" SIGINT 

check_root() {
    if [[ "$(whoami)" != "root" ]] ; then 
        echo "Please run this script as root."
        echo "It is needed to unmount the disk in the main loop. Check my code."
        exit
    fi
} 

undo() {
    echo "Removing /tmp/sd-card.vmdk from $2"
    VBoxManage storageattach $2 --storagectl "IDE" --device 0 --port 1 --type hdd --medium none || :
    echo "OK"

    echo "rm /tmp/sd-card.vmdk"
    rm /tmp/sd-card.vmdk || :
    echo "OK"
}

undo_and_exit() {
    echo "Stopped, undoing changes"
    undo $1 $2
    sleep 1
    exit
}

check_root

undo $1 $2

echo "Unmounting $1"
diskutil unmountDisk $1 

echo "Creating vmdk in /tmp"
VBoxManage internalcommands createrawvmdk -filename /tmp/sd-card.vmdk -rawdisk $1

echo "Setting permissions"
chmod 666 $1 /tmp/sd-card.vmdk 
echo "OK"

echo "Unmounting $1"
diskutil unmountDisk $1 || :

echo "Adding it to your VM"
VBoxManage storageattach $2 --storagectl "IDE" --device 0 --port 1 --type hdd --medium /tmp/sd-card.vmdk
echo "OK"

echo "I will enter a loop to keep unmounting the disk so you don't have any error while starting the vm"
echo "When done Press Ctrl+C and I will remove the vmdk file"
while [[ 1 ]] ; do 
    if [[ "$(mount | grep $1)" != "" ]] ; then
        diskutil unmountDisk $1 
    else
        echo "$1 not mounted continuing. Press Ctrl+C to stop."
    fi
    sleep 2
done

