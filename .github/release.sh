#!/bin/bash

FILENAMES=$(ls)
for FILENAME in $FILENAMES
do
	gzip -S ".gz" $FILENAME
done

FILENAMES=$(ls)
for FILENAME in $FILENAMES
do
    if [[ $FILENAME =~ ".zip" ]];then
        echo "rename $FILENAME"
        mv $FILENAME ${FILENAME%.*}-${VERSION}.zip
    elif [[ $FILENAME =~ ".gz" ]];then
        echo "rename $FILENAME"
        mv $FILENAME ${FILENAME%.*}-${VERSION}.gz
    else
        echo "skip $FILENAME"
    fi
done