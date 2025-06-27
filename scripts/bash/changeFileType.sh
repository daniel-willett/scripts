#!/usr/bin/env bash

startExtention=$1
endExtention=$2

if [ "$startExtention" == "-h" ] || [ "$startExtention" == "--help" ]; then
	echo "$(changeFileType-help)"
else
	for file in *."$startExtention" ; do 
		mv -- "$file" "${file%.$startExtention}.$endExtention"
	done
fi
