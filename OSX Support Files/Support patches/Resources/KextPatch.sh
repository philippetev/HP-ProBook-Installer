#!/bin/bash
set -x
kextdir="$2/System/Library/Extensions"
HDAbinary="$kextdir/AppleHDA.kext/Contents/MacOS/AppleHDA"
HDAplist="$kextdir/AppleHDA.kext/Contents/PlugIns/AppleHDAHardwareConfigDriver.kext/Contents/Info.plist"
AICPMbin="$kextdir/AppleIntelCPUPowerManagement.kext/Contents/MacOS/AppleIntelCPUPowerManagement"
SNBbinary="$kextdir/AppleIntelSNBGraphicsFB.kext/Contents/MacOS/AppleIntelSNBGraphicsFB"
IVYbinary="$kextdir/AppleIntelFramebufferCapri.kext/Contents/MacOS/AppleIntelFramebufferCapri"
RTCBinary="$kextdir/AppleRTC.kext/Contents/MacOS/AppleRTC"
PostHDA () {
case $2 in
old)	rm -f "$kextdir"/AppleHDA.kext/Contents/Resources/*.xml
		install -m 644 -o root -g wheel ./Lion/*.xml "$kextdir"/AppleHDA.kext/Contents/Resources
		;;
new)	rm -f "$kextdir"/AppleHDA.kext/Contents/Resources/*.zlib
		install -m 644 -o root -g wheel ./ML/*.zlib "$kextdir"/AppleHDA.kext/Contents/Resources
		;;
ivy)	rm -f "$kextdir"/AppleHDA.kext/Contents/Resources/*.zlib
		install -m 644 -o root -g wheel ./Ivy/*.zlib "$kextdir"/AppleHDA.kext/Contents/Resources
		;;
esac
/usr/libexec/plistbuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:HDAConfigDefault'" "$HDAplist"
/usr/libexec/plistbuddy -c "Delete ':IOKitPersonalities:HDA Hardware Config Resource:PostConstructionInitialization'" "$HDAplist"
case $1 in
4x30)	/usr/libexec/plistbuddy -c "Merge ./4x30s.plist ':IOKitPersonalities:HDA Hardware Config Resource'" "$HDAplist"
		;;
4x40)	/usr/libexec/plistbuddy -c "Merge ./4x40s.plist ':IOKitPersonalities:HDA Hardware Config Resource'" "$HDAplist"
		;;
esac
}

while read vanilla; do
patch=`echo $vanilla | awk -F '<=>' '{print $3}'`
case $patch in
aicpm)	perl ./AICPMPatch.pl "$AICPMbin" --patch
		;;
hda3l)	perl ./patch-hda.pl 'IDT 76d1' -s "$kextdir"
		PostHDA 4x30 old
		;;
hda3m)	perl ./patch-hda.pl 'IDT 76d1' -s "$kextdir"
		PostHDA 4x30 new
		;;
hda4m)	perl ./patch-hda.pl 'IDT 76d9' -s "$kextdir"
		PostHDA 4x40 ivy
		;;
fbsnb)	perl -pi -e 's|\x01\x02\x04\x00\x10\x07\x00\x00\x10\x07\x00\x00\x05\x03\x00\x00\x02\x00\x00\x00\x30\x00\x00\x00\x02\x05\x00\x00\x00\x04\x00\x00\x07\x00\x00\x00\x03\x04\x00\x00\x00\x04\x00\x00\x09\x00\x00\x00\x04\x06\x00\x00\x00\x04\x00\x00\x09\x00\x00\x00|\x01\x02\x03\x00\x10\x07\x00\x00\x10\x07\x00\x00\x06\x02\x00\x00\x00\x01\x00\x00\x09\x00\x00\x00\x05\x03\x00\x00\x02\x00\x00\x00\x30\x00\x00\x00\x04\x06\x00\x00\x00\x08\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00|g' "$SNBbinary"
		;;
fbivy)	perl -pi -e 's|\x09\x00\x66\x01\x01\x03\x03\x03\x00\x00\x00\x04\x00\x00\x00\x01\x00\x00\x00\x20\x10\x07\x00\x00\x10\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF0\xD9\x05\x00\x00\x00\x00\x00\x01\x00\x00\x00\x02\x00\x00\x00\x30\x00\x00\x00\x02\x05\x00\x00\x00\x04\x00\x00\x07\x01\x00\x00\x03\x04\x00\x00\x00\x04\x00\x00\x07\x01\x00\x00|\x09\x00\x66\x01\x01\x03\x03\x03\x00\x00\x00\x04\x00\x00\x00\x01\x00\x00\x00\x20\x10\x07\x00\x00\x10\x07\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\xF0\xD9\x05\x00\x00\x00\x00\x00\x05\x03\x00\x00\x02\x00\x00\x00\x30\x02\x00\x00\x03\x04\x00\x00\x00\x04\x00\x00\x07\x01\x00\x00\x04\x06\x00\x00\x00\x08\x00\x00\x06\x00\x00\x00|' "$IVYbinary"
		;;
aprtc)	perl -pi -e 's|\x75\x30\x89\xd8|\xeb\x30\x89\xd8|' "$RTCBinary"
		;;
esac	
done < $1