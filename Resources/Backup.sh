#!/bin/bash
set -x
RightNowIs=`/usr/libexec/PlistBuddy -c "Print :CurrentDateTime" /tmp/PBI.plist`
BackupDir="$HOME/Desktop/Installer Backups/Backup $RightNowIs"
while read vanilla; do
filename=`echo $vanilla | awk -F '<=>' '{print $1}'`
flag=`echo $vanilla | awk -F '<=>' '{print $2}'`
if [ -e "$2/$filename" ]
then
	if [ ! -e "$BackupDir" ]
	then
		mkdir -p "$BackupDir"
	fi
	cp -Rf "$2/$filename" "$BackupDir"
	if [ "$flag" == "y" ]
	then
		rm -rf "$2/$filename"
	fi
fi
done < $1