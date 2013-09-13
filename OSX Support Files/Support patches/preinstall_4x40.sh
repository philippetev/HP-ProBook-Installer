#!/bin/bash
set -x
osxver=`/usr/libexec/PlistBuddy -c 'Print ProductVersion' "${3}"/System/Library/CoreServices/SystemVersion.plist`
case $osxver in
10.8*)	echo "OS X Mountain Lion $osxver detected."
		./Backup.sh ./list_4x40ml "${3}"
		;;
10.9*)	echo "OS X Mavericks $osxver detected."
		./Backup.sh ./list_4x40ml "${3}"
		;;
*)		echo "Unknown or unsupported OS X version, aborting."
		;;
esac