#!/bin/bash


if [[ -z "$SUDO_COMMAND" ]]; then
	echo 'This needs to be run as sudo'
else
	cd
	killall VBoxService
	VBoxClient --clipboard
	echo "Complete"
fi
