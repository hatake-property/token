#!/bin/bash

path=""

if [ $# -eq 0 ]; then
	i=1
	while true; do
		path="untitled-$i.txt"
		if [ ! -f "$path" ]; then
			break
		fi
		(( i++ ))
	done
else
	path=$1
fi

echo "$path"

cmd=""

while true; do
	read -s -n 1 key
	cmd+="$key"
	case "$cmd" in
		[Qq])
			# Quit Program
			break
			;;
		[Rr])
			# Rename File Name
			echo -n "rename "
			read new_path
			mv "$path" "$new_path"
			path=$new_path
			;;
		*)
			# Reset Cmd
			cmd=""
			;;
	esac
done
