#!/bin/bash

FILENAMES=$(ls)
for FILENAME in $FILENAMES
do
    if [[ $FILENAME =~ "darwin-10.16-arm64" ]];then
        echo "rename darwin-10.16-arm64 $FILENAME"
        mv $FILENAME clash.meta-darwin-arm64-cgo.dylib
    elif [[ $FILENAME =~ "darwin-10.16-amd64" ]];then
        echo "rename darwin-10.16-amd64 $FILENAME"
        mv $FILENAME clash.meta-darwin-amd64-cgo.dylib
    elif [[ $FILENAME =~ "windows-4.0-386" ]];then
        echo "rename windows 386 $FILENAME"
        mv $FILENAME clash.meta-windows-386-cgo.dll
    elif [[ $FILENAME =~ "windows-4.0-amd64" ]];then
        echo "rename windows amd64 $FILENAME"
        mv $FILENAME clash.meta-windows-amd64-cgo.dll
    elif [[ $FILENAME =~ "clash.meta-linux-arm-5" ]];then
        echo "rename clash.meta-linux-arm-5 $FILENAME"
        mv $FILENAME clash.meta-linux-armv5-cgo.so
    elif [[ $FILENAME =~ "clash.meta-linux-arm-6" ]];then
        echo "rename clash.meta-linux-arm-6 $FILENAME"
        mv $FILENAME clash.meta-linux-armv6-cgo.so
    elif [[ $FILENAME =~ "clash.meta-linux-arm-7" ]];then
        echo "rename clash.meta-linux-arm-7 $FILENAME"
        mv $FILENAME clash.meta-linux-armv7-cgo.so
    elif [[ $FILENAME =~ "linux" ]];then
        echo "rename linux $FILENAME"
        mv $FILENAME $FILENAME-cgo.so
    elif [[ $FILENAME =~ "android" ]];then
        echo "rename android $FILENAME"
        mv $FILENAME $FILENAME-cgo.so
    else echo "skip $FILENAME"
    fi
done