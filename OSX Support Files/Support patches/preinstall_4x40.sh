#!/bin/bash
set -x
osxver=`/usr/libexec/PlistBuddy -c 'Print ProductVersion' "${3}"/System/Library/CoreServices/SystemVersion.plist`
case $osxver in
10.6.8)	echo "OS X Snow Leopard $osxver detected."
		./Backup.sh ./list_4x40sl "${3}";;
10.7.5)	echo "OS X Lion $osxver detected."
		./Backup.sh ./list_4x40l "${3}";;
10.8*)	echo "OS X Mountain Lion $osxver detected."
		./Backup.sh ./list_4x40ml "${3}";;
10.9*)	echo "OS X Mavericks $osxver detected."
		./Backup.sh ./list_4x40mav "${3}";;
10.10*)	echo "OS X Yosemite $osxver detected."
		./Backup.sh ./list_4x40mav "${3}";;
*)		echo "Unknown or unsupported OS X version, aborting.";;
esac