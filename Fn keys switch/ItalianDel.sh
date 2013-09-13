#!/bin/bash
kextdir="$DSTVOLUME/System/Library/Extensions"
KBplist="$kextdir/VoodooPS2Controller.kext/Contents/PlugIns/VoodooPS2Keyboard.kext/Contents/Info.plist"
cond1=`/usr/libexec/PlistBuddy -c "Print ':IOKitPersonalities:ApplePS2Keyboard:Custom PS2 Map:1'" "$KBplist"`
if [ "$cond1" == ";Italian keyboard fix" ]
then
	/usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:ApplePS2Keyboard:Custom PS2 Map:3'" "$KBplist"
	/usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:ApplePS2Keyboard:Custom PS2 Map:2'" "$KBplist"
	/usr/libexec/PlistBuddy -c "Delete ':IOKitPersonalities:ApplePS2Keyboard:Custom PS2 Map:1'" "$KBplist"
else
	echo "The fix is already removed!"
	exit 0
fi