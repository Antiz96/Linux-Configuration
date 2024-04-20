#!/bin/bash

option="${1}"
argument="${2}"
backup_dir="/run/media/antiz/data/Backup/System_Backup"

rsync_cmd() {
	rsync -aAXHv \
	--exclude='/dev/*' \
	--exclude='/proc/*' \
	--exclude='/sys/*' \
	--exclude='/tmp/*' \
	--exclude='/run/*' \
	--exclude='/mnt/*' \
	--exclude='/media/*' \
	--exclude='/lost+found/' \
	--exclude='/var/cache/pacman/pkg/*' \
	--exclude='/var/lib/archbuild/*' \
	--exclude='/var/lib/aurbuild/*' \
	--exclude='/var/lib/docker/*' \
	--exclude='/root/*' \
	--exclude='/home/*' \
	"${source_dir}" "${dest_dir}"
}

if [ "${EUID}" -ne 0 ]; then
	echo "Please run as root"
  	exit 1
fi


case "${option}" in
	-C|--create)
		source_dir="/"
		
		if [ "${argument}" == "--scheduled" ]; then
			dest_dir="$(date +%d-%m-%Y_%H-%M)-daily"
		elif [ "${argument}" == "--ondemand" ]; then
			dest_dir="$(date +%d-%m-%Y_%H-%M)-ondemand"
		else
			echo -e >&2 "Invalid or missing argument\nUsage: --create --scheduled|--ondemand"
			exit 4
		fi

		 # shellcheck disable=SC2015
		cd "${backup_dir}" && rsync_cmd && find "${backup_dir}" -mindepth 1 -maxdepth 1 -type d -ctime +6 -exec rm -rf {} \; || { echo -e >&2 "\nSystem Backup failed" && sudo -u antiz DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send -u critical -t 300000 "System Backup" "System Backup failed"; exit 2; }
	;;
	-R|--restore)
		if [ -n "${argument}" ]; then
			source_dir="${argument##*/}/*"
			dest_dir="/"
			
		 	# shellcheck disable=SC2015
			cd "${backup_dir}" && rsync_cmd && echo -e "\nThe restoration is done\nPlease, reboot the system" || { echo -e >&2 "\nAn error occurred during the restoration process"; exit 3; }
		else
			echo -e >&2 "Missing argument\nUsage: --restore '<path to snapshot>'"
			exit 4
		fi
	;;
	*)
		echo -e >&2 "Invalid option"
		exit 4
	;;
esac