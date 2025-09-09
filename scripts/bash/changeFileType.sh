#!/usr/bin/env bash

default() {
	startExtension=$1
	endExtension=$2
	for file in *."$startExtension" ; do
		mv -- "$file" "${file%.$startExtension}.$endExtension"
	done
	echo "Moved all files within this directory with extension $startExtension to $endExtension"
}

stripFunc(){
	startExtension=$1
	for file in *."$startExtension" ; do
                mv -- "$file" "${file%.$startExtension}"
        done
	echo "Stripped all files within this directory with extension $startExtension to no extension"
}

addFunc(){
	endExtension=$1
	for file in * ; do
                if [[ -f "$file" && "$file" != *.* ]]; then
                        mv -- "$file" "$file.$endExtension"
                fi
        done
	echo "Added all files within this directory with extension no extension to $startExtension extension"
}

## https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash?page=1&tab=scoredesc#tab-top
## https://www.gnu.org/software/bash/manual/bash.html#Special-Parameters
## https://www.pluralsight.com/resources/blog/cloud/conditions-in-bash-scripting-if-statements#h-table-of-conditions

#options --option/-o
#requires at least 1 argument
LONGOPTS=help,strip,add
OPTIONS=hsa

#We store the output
#Activate quoting/enhanced mode by "--options"
#pass arguments only via   -- "$@"   to separate them correctly
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@") || exit 2

#read getopt's output this way to handle quoting right:
eval set -- "$PARSED"

while true; do
        case "$1" in
                -h|--help)
			less changeFileType-help
                        exit
                        ;;
                -s|--strip)
			shift
			if [[ $# -ne 2 ]]; then
				echo "-s/--strip requires only 1 file extension input and cannot be combined with -a/--add "
				exit 4
			fi
			stripFunc "$2"
			break
                        ;;
                -a|--add)
			shift
			if [[ $# -ne 2 ]]; then
				echo "-a/--add requires only 1 file extension input and cannot be combined with -s/--strip"
				exit 4
			fi
			addFunc "$2"
			break
                        ;;
                --)
			shift
			default "$1" "$2"
                        break
                        ;;
                *)
                        echo "Error"
                        exit 3
                        ;;
        esac
done

