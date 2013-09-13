#!/bin/bash
kextdir="$DSTVOLUME/System/Library/Extensions"
KBplist="$kextdir/VoodooPS2Controller.kext/Contents/PlugIns/VoodooPS2Keyboard.kext/Contents/Info.plist"
cond1=`/usr/libexec/PlistBuddy -c "Print ':IOKitPersonalities:ApplePS2Keyboard:Custom PS2 Map:1'" "$KBplist"`
if [ "$cond1" == ";Italian keyboard fix" ]
then
	echo "The fix is already applied!"
	exit 0
else
	/usr/libexec/PlistBuddy -c "Add ':IOKitPersonalities:ApplePS2Keyboard:Custom PS2 Map:1' string ';Italian keyboard fix'" "$KBplist"
	/usr/libexec/PlistBuddy -c "Add ':IOKitPersonalities:ApplePS2Keyboard:Custom PS2 Map:2' string '56=29'" "$KBplist"
	/usr/libexec/PlistBuddy -c "Add ':IOKitPersonalities:ApplePS2Keyboard:Custom PS2 Map:3' string '29=56'" "$KBplist"
fi