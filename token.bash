#!/bin/bash

path=""
carret=0
token=()
col=$(tput cols)
row=$(tput lines)

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
	if [ -e "$path" ]; then
		s=""
		content=$(<"$path")
		for (( i=0; i<${#content}; i++ )); do
			c="${content:i:1}"
			case "$c" in
			$'\n')
				token+=("$s")
				s="$c"
				;;
			" ")
				if [ "${s:0:1}" != " " ]
				then
					token+=("$s")
					s=""
				fi
				s+="$c"
				;;
			*)
				if [ "${s:0:1}" = " " ] || [ "${s:0:1}" = $'\n' ]
				then
					token+=("$s")
					s=""
				fi
				s+="$c"
				;;
			esac
		done
		token+=("$s")
	else
		content=""
	fi
fi

echo "$path"

cmd=""

while true; do
	for (( i=0; i<${#token[@]}; i++ )); do
		if [ $1 -eq $carret ]; then
			echo -n "\033[7m"
		fi
		echo -n "${token[$i]}"
		if [ $1 -eq $carret ]; then
			echo -n "\033[7m"
		fi
	done
	read -s -n 1 key
	cmd+="$key"
	case "$cmd" in
		# Prefix
		[Gg])
			# Get ......
			echo -n "get "
			;;
		# Cmd
		[Ff])
			# Move Carret to the Left
			if [ $carret -ne 0 ]; then
				(( carret-- ))
			fi
			;;
		[Gg][Cc])
			# Get Columns
			echo "columns: $col"
			;;
		[Gg][Pp])
			# Get File Name
			echo "get file path"
			echo "$path"
			;;
		[Gg][Rr])
			# Get Row
			echo "row: $row"
			;;
		[Jj])
			# Move Carret to the Right
			if [ $carret -lt ${#token[@]} ]; then
				(( carret++ ))
			fi
			;;
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
