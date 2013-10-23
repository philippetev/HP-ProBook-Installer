#!/bin/bash
set -x
osxver=`/usr/libexec/PlistBuddy -c 'Print ProductVersion' "${3}"/System/Library/CoreServices/SystemVersion.plist`
case $osxver in
10.8*)	echo "OS X Mountain Lion $osxver detected."
		./KextPatch.sh ./list_6x70ml "${3}"
		cp ./boot_ml.plist "${3}"/Extra/org.chameleon.Boot.plist
		;;
10.9*)	echo "OS X Mavericks $osxver detected."
		./KextPatch.sh ./list_6x70mav "${3}"
		cp ./boot_ml.plist "${3}"/Extra/org.chameleon.Boot.plist
		;;
*)		echo "Unknown or unsupported OS X version, aborting."
		;;
esac
# disabling Software Update schedule.
softwareupdate --schedule off
# triggering kext cache rebuilding
/usr/libexec/PlistBuddy -c "Set :KextCacheRebuild yes" /tmp/PBI.plist