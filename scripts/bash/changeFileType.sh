#!/usr/bin/env bash

startExtension=$1
endExtension=$2

if [ "$startExtension" == "-h" ] || [ "$startExtension" == "--help" ]; then
	less changeFileType-help
	exit 1
elif [ "$startExtension" == "-s" ] || [ "$startExtension" == "--strip" ]; then
	startExtension=$endExtension
	for file in *."$startExtension" ; do
		mv -- "$file" "${file%.$startExtension}"
	done
	echo "Stripped all files within this directory with extension $startExtension to no extension"
	exit 1
elif [ "$startExtension" == "-a" ] || [ "$startExtension" == "--add" ]; then
	for file in * ; do
		if [[ -f "$file" && "$file" != *.* ]]; then
			mv -- "$file" "$file.$endExtension"
		fi
	done
	echo "Added all files within this directory with extension no extension to $startExtension extension"
	exit 1


fi


for file in *."$startExtension" ; do 
	mv -- "$file" "${file%.$startExtension}.$endExtension"
done
echo "Moved all files within this directory with extension $startExtension to $endExtension"
exit 1
