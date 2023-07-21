#!/bin/bash

FILENAMES=$(ls)
ls
for FILENAME in $FILENAMES
do
    if [[ $FILENAME =~ "darwin-10.12-arm64" ]];then
        echo "rename darwin-arm64 $FILENAME"
        mv $FILENAME hiddify_clashlib-darwin-arm64-cgo.dylib
    elif [[ $FILENAME =~ "darwin-10.12-amd64" ]];then
        echo "rename darwin-amd64 $FILENAME"
        mv $FILENAME hiddify_clashlib-darwin-amd64-cgo.dylib
    elif [[ $FILENAME =~ "windows-4.0-386" ]];then
        echo "rename windows 386 $FILENAME"
        mv $FILENAME hiddify_clashlib-windows-386-cgo.dll
    elif [[ $FILENAME =~ "windows-4.0-amd64" ]];then
        echo "rename windows amd64 $FILENAME"
        mv $FILENAME hiddify_clashlib-windows-amd64-cgo.dll
    elif [[ $FILENAME =~ "hiddify_clashlib-linux-arm-5" ]];then
        echo "rename hiddify_clashlib-linux-arm-5 $FILENAME"
        mv $FILENAME hiddify_clashlib-linux-armv5-cgo.so
    elif [[ $FILENAME =~ "hiddify_clashlib-linux-arm-6" ]];then
        echo "rename hiddify_clashlib-linux-arm-6 $FILENAME"
        mv $FILENAME hiddify_clashlib-linux-armv6-cgo.so
    elif [[ $FILENAME =~ "hiddify_clashlib-linux-arm-7" ]];then
        echo "rename hiddify_clashlib-linux-arm-7 $FILENAME"
        mv $FILENAME hiddify_clashlib-linux-armv7-cgo.so
    elif [[ $FILENAME =~ "linux" ]];then
        echo "rename linux $FILENAME"
        mv $FILENAME $FILENAME-linux-cgo.so
    elif [[ $FILENAME =~ "android" ]];then
        echo "rename android $FILENAME"
        mv $FILENAME $FILENAME-cgo.so
    else echo "skip $FILENAME"
    fi
done
