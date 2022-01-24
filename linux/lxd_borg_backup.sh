CONTAINERS="cnt1 cnt2 cnt3"
USB_STORAGE="/media/usb"

BKPUSER="bkpuser"

GDRIVE_REPO_SERVER="192.168.0.100"
GDRIVE_REPO_SERVER_PORT="22"
GDRIVE_REPO_PATH="~/googledrive/myhost"
GDRIVE_REPO_PASSPHRASE="/home/passuser/.password"

SSHFS_REPO_SERVER="192.168.0.100"
SSHFS_REPO_SERVER_PORT="22"
SSHFS_REPO_PATH="~/sshfsshare/myhost"
SSHFS_REPO_PASSPHRASE="/home/passuser/.password"

NUMBER_OF_BACKUPS_TO_KEEP_AFTER_PRUNE=2

# some helpers and error handling:
info() { printf "\n%s %s\n\n" "$( date )" "$*" >&2; }
trap 'echo $( date ) Backup interrupted >&2; exit 2' INT TERM

info "Backuping LXD containers to local USB storage"
for i in $CONTAINERS; do
	SNAPSHOT=$(date +%F)
	info "creating snapshot for $i"
	/snap/bin/lxc snapshot $i $SNAPSHOT
	info "creating temporary image for $i"
	/snap/bin/lxc publish $i/$SNAPSHOT --alias tmp_img
	info "exporting image for $i"
	/snap/bin/lxc image export tmp_img $USB_STORAGE
	info "deleteing temporary image for $i"
	/snap/bin/lxc image delete tmp_img
done

info "Starting backup to gdrive"

export BORG_REPO=ssh://$BKPUSER@$GDRIVE_REPO_SERVER:$GDRIVE_REPO_SERVER_PORT/$GDRIVE_REPO_PATH
export BORG_PASSPHRASE=$(cat $GDRIVE_REPO_PASSPHRASE)

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude-caches                \
                                    \
    ::'{hostname}-{now}'            \
    /var/log/syslog
    /another/example

backup_exit=$?

info "Pruning Gdrive repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-last $NUMBER_OF_BACKUPS_TO_KEEP_AFTER_PRUNE

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "Gdrive Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "Gdrive Backup and/or Prune finished with warnings"
else
    info "Gdrive Backup and/or Prune finished with errors"
fi

# Now do it again for sshfs backup
info "Starting backup to sshfs (local repo)"

export BORG_REPO=ssh://$BKPUSER@$SSHFS_REPO_SERVER:$SSHFS_REPO_SERVER_PORT/$SSHFS_REPO_PATH
export BORG_PASSPHRASE=$(cat $SSHFS_REPO_PASSPHRASE)

# Backup the most important directories into an archive named after
# the machine this script is currently running on:

borg create                         \
    --verbose                       \
    --filter AME                    \
    --list                          \
    --stats                         \
    --show-rc                       \
    --compression lz4               \
    --exclude-caches                \
                                    \
    ::'{hostname}-{now}'            \
    /var/log/syslog
    /another/example

backup_exit=$?

info "Pruning sshfs (local) repository"

# Use the `prune` subcommand to maintain 7 daily, 4 weekly and 6 monthly
# archives of THIS machine. The '{hostname}-' prefix is very important to
# limit prune's operation to this machine's archives and not apply to
# other machines' archives also:

borg prune                          \
    --list                          \
    --prefix '{hostname}-'          \
    --show-rc                       \
    --keep-last $NUMBER_OF_BACKUPS_TO_KEEP_AFTER_PRUNE

prune_exit=$?

# use highest exit code as global exit code
global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

if [ ${global_exit} -eq 0 ]; then
    info "SSHFS Backup and Prune finished successfully"
elif [ ${global_exit} -eq 1 ]; then
    info "SSHFS Backup and/or Prune finished with warnings"
else
    info "SSHFS Backup and/or Prune finished with errors"
fi

exit ${global_exit}
