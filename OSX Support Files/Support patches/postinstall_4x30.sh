#!/bin/bash
set -x
unzip ./hdafiles.zip -d .
osxver=`/usr/libexec/PlistBuddy -c 'Print ProductVersion' "${3}"/System/Library/CoreServices/SystemVersion.plist`
case $osxver in
10.6.8)	echo "OS X Snow Leopard $osxver detected."
		./KextPatch.sh ./list_4x30sl "${3}"
		cp ./boot_plists/boot_sl.plist "${3}"/Extra/org.chameleon.Boot.plist
		;;
10.7*)	echo "OS X Lion $osxver detected."
		./KextPatch.sh ./list_4x30l "${3}"
		cp ./boot_plists/boot_ml.plist "${3}"/Extra/org.chameleon.Boot.plist
		;;
10.8*)	echo "OS X Mountain Lion $osxver detected."
		./KextPatch.sh ./list_4x30ml "${3}"
		cp ./boot_plists/boot_ml.plist "${3}"/Extra/org.chameleon.Boot.plist
		;;
10.9*)	echo "OS X Mavericks $osxver detected."
		./KextPatch.sh ./list_4x30ml "${3}"
		cp ./boot_plists/boot_ml.plist "${3}"/Extra/org.chameleon.Boot.plist
		;;
*)		echo "Unknown or unsupported OS X version, aborting."
		;;
esac
# disabling Software Update schedule.
softwareupdate --schedule off
# triggering kext cache rebuilding
/usr/libexec/PlistBuddy -c "Set :KextCacheRebuild yes" /tmp/PBI.plist