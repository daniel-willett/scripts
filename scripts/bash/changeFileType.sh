#!/usr/bin/env bash

startExtention=$1
endExtention=$2

if [ "$startExtention" == "-h" ] || [ "$startExtention" == "--help" ]; then
	echo "$(changeFileType-help)"
	exit 1
elif [ "$startExtention" == "-s" ] || [ "$startExtention" == "--strip" ]; then
	startExtention=$endExtention
	for file in *."$startExtention" ; do
		mv -- "$file" "${file%.$startExtention}"
	done
	echo "Stripped all files within this directory with extention $startExtention to no extention"
	exit 1
fi


for file in *."$startExtention" ; do 
	mv -- "$file" "${file%.$startExtention}.$endExtention"
done
echo "Moved all files within this directory with extention $startExtention to $endExtention"
exit 1
