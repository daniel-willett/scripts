#!/usr/bin/env bash

default() {
	startExtension=$1
	endExtension=$2
	for file in *."$startExtension" ; do
		if [[ $v == true ]]; then
			echo "$file --> ${file%.$startExtension}.$endExtension"
		fi
		mv -- "$file" "${file%.$startExtension}.$endExtension"
	done
	echo "Moved all files within this directory with extension $startExtension to $endExtension"
}

stripFunc(){
	startExtension=$1
	for file in *."$startExtension" ; do
		if [[ $v == true ]]; then
			echo "$file --> ${file%.$startExtension}"
		fi
                mv -- "$file" "${file%.$startExtension}"
        done
	echo "Stripped all files within this directory with extension $startExtension to no extension"
}

addFunc(){
	endExtension=$1
	for file in * ; do
                if [[ -f $file && $file != *.* ]]; then
			if [[ $v == true ]]; then
				echo "$file --> $file.$endExtension"
			fi
                        mv -- "$file" "$file.$endExtension"
                fi
        done
	echo "Added all files within this directory with no extension to $endExtension extension"
}

## https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash?page=1&tab=scoredesc#tab-top
## https://www.gnu.org/software/bash/manual/bash.html#Special-Parameters
## https://www.pluralsight.com/resources/blog/cloud/conditions-in-bash-scripting-if-statements#h-table-of-conditions
## https://stackoverflow.com/questions/3427872/whats-the-difference-between-and-in-bash

#options --option/-o
#requires at least 1 argument
LONGOPTS=help,strip,add,verbose
OPTIONS=hsav

#We store the output
#Activate quoting/enhanced mode by "--options"
#pass arguments only via   -- "$@"   to separate them correctly
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@") || exit 2

#read getopt's output this way to handle quoting right:
eval set -- "$PARSED"

s=false
a=false
v=false

while true; do
        case "$1" in
                -h|--help)
			less changeFileType-help
                        exit
                        ;;
                -s|--strip)
			shift
			s=true
                        ;;
                -a|--add)
			shift
			a=true
                        ;;
		-v|verbose)
			shift
			v=true
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

if [[ $a == true && $s == true ]]; then
	echo "-a/--add and -s/--strip aren't compatible. Pick one"
	exit
elif [[ $a == true ]]; then
	if [[ $# -ne 1 ]]; then
		echo "-a/--add requires only 1 file extension input"
		exit
	fi
	addFunc "$1"
elif [[ $s == true ]]; then
	if [[ $# -ne 1 ]]; then
		echo "-s/--strip requires only 1 file extension input"
		exit
	fi
	stripFunc "$1"
else
	default "$1" "$2"
fi
