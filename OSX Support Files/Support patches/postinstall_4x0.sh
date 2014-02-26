#!/bin/bash
set -x
osxver=`/usr/libexec/PlistBuddy -c 'Print ProductVersion' "${3}"/System/Library/CoreServices/SystemVersion.plist`
case $osxver in
10.8*)	echo "OS X Mountain Lion $osxver detected."
		./KextPatch.sh ./list_4x0ml "${3}";;
10.9*)	echo "OS X Mavericks $osxver detected."
		./KextPatch.sh ./list_4x0mav "${3}";;
*)		echo "Unknown or unsupported OS X version, aborting.";;
esac
if [ ! -f "${3}"/Extra/org.chameleon.Boot.plist ]
then
	case $osxver in
	10.8*|10.9*) cp ./boot_ml.plist "${3}"/Extra/org.chameleon.Boot.plist;;
	*)	echo "Unknown or unsupported OS X version, aborting.";;
	esac
fi
# disabling Software Update schedule.
softwareupdate --schedule off