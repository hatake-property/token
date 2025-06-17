#!/bin/bash

path=""

if [ $# -eq 0 ]; then
	for (( i=0; true; i++ )); do
		path="untitled-$i.txt"
		if [ ! -f $path ]; then
			break
		fi
	done
else
	path=$1
fi

cmd=""

while true; do
	read -s -n 1 key
	cmd+=key
	case cmd in
		[Qq])
			# Quit Program
			break
			;;
		*)
			# Reset Cmd
			cmd=""
			;;
	esac
done
