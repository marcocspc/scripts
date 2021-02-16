# This script should be able to backup your entire sdcard to some external usb flash drive
# Before running it, you must inform which processes are keeping your root filesystem busy. To find them, you can use the following commands (as root):
# This command will show processes names and PIDs. Use them to stop their services with systemctl:
# sudo lsof / | awk '$4 ~ /[0-9].*w/'
# After finding which processes are keeping you sd card busy, write down their service names and their names. Some of them will be stopped via systemctl, some of them are going to be stopped by a gently "kill -15". So you need to fill the variables below accordingly to the process list of your system:

#Services that are keeping root filesystem busy:
SYSTEMCTL_STOP_SERVICES=(
    "docker"
    "example_2"
)

#Processes names that are keeping root filesystem busy:
KILL_15_PROCESSES=(
    "firefox" #example
)

#SD Card disk:
SD_CARD_DISK="/dev/sda" #example

#Backup destination folder (where the external drive is mounted):
BACKUP_DIR="/example/path"

#Log backup?
LOG_BACKUP="y"

#Date
TODAY=$(date + "%Y-%m-%d")

#### BACKUP START #####

#stop services
for service in ${SYSTEMCTL_STOP_SERVICES[@]}; do
    systemctl stop $service
done

#gently kill remaining processes
for process_name in ${KILL_15_PROCESSES[@]}; do
    kill -15 $service
done

#stop swap usage
swapoff -a -e

#remount root read-only
mount -r -o remount /

#start backup
dd if=$SD_CARD_DISK | gzip > "$BACKUP_DIR/backup_root_filesystem_$TODAY.img.gz"

#reboot
reboot
