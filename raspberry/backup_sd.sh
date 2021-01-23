# This script should be able to backup your entire sdcard to some external usb flash drive
# Before running it, you must inform which processes are keeping your root filesystem busy. To find them, you can use the following commands (as root):
# This command will show processes names and PIDs. Use them to stop their services with systemctl:
# sudo lsof / | awk '$4 ~ /[0-9].*w/'
# After finding which processes are keeping you sd card busy, write down their service names and their names. Some of them will be stopped via systemctl, some of them are going to be stopped by a gently "kill -15". So you need to fill the variables below accordingly to the process list of your system:

#Services that are keeping root filesystem busy:
SYTEMCTL_STOP_SERVICES=(
    "docker"
    "example_2"
)

#Processes names that are keeping root filesystem busy:
KILL_15_PROCESSES=(
    "firefox" #example
)

#SD Card disk:
SD_CARD_DISK="/dev/sda" #example

#Backup destination folder:
BACKUP_DIR="/example/path"

#Log backup?
LOG_BACKUP="y"

#### BACKUP START #####

#stop services

#gently kill remaining processes

#stop swap usage

#remount root read-only

#start backup

#reboot
