#!/usr/bin/env bash


## https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash?page=1&tab=scoredesc#tab-top


#options --longer/-l
#requires at least 1 argument
LONGOPTS=help,strip,:add
OPTIONS=hsa

#We store the output
#Activate quoting/enhanced mode by "--options"
#pass arguments only via   -- "$@"   to separate them correctly
#if getopt fails, it complains itself ot stderr
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@") || exit 2

#read getopt's output this way to handle quoting right:
eval set -- "$PARSED"

#initialise
h=false s=false a=false

while true; do
	case "$1" in
		-h|--help)
			h=true
			shift
			;;
		-s|--strip)
			s=true
			shift
			;;
		-a|--add)
			a=true
			shift
			;;
		--)
			shift
			break
			;;
		*)
			echo "Error"
			exit 3
			;;
	esac
done

#handle non-option arguments
if [[ $# -ne 1]]; then
	echo "$0: a single input file is required."
	exit 4
fi

echo "verbose: $v, force: $f, debug: $d, in: $1, out $2"

#
#=======================
#
#=======================

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
