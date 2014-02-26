#!/bin/bash
set -x
RightNowIs=`/usr/libexec/PlistBuddy -c "Print :CurrentDateTime" /tmp/PBI.plist`
BackupDir="$HOME/Desktop/Installer Backups/Backup $RightNowIs"
while read vanilla; do
kext=`echo $vanilla | awk -F '<=>' '{print $1}'`
flag=`echo $vanilla | awk -F '<=>' '{print $2}'`
if [ -e "$2$kext" ]
then
	if [ ! -e "$BackupDir" ]
	then
		mkdir -p "$BackupDir"
	fi
	cp -Rf "$2$kext" "$BackupDir"
	case $flag in
	y)	rm -rf "$2$kext"
		;;
	n)	echo "$2$kext will be patched."
		./finder_colors.py red "$2$kext"
		;;
	*)	part=`eval echo $flag`
		rm -rf "$2$part"
		;;
	esac	
fi
done < $1
/usr/libexec/PlistBuddy -c "Set :KextCacheRebuild yes" /tmp/PBI.plist