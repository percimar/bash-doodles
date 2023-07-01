#!/bin/bash

# Usage zigzag [COLUMN_WIDTH] [SCREEN_WIDTH]
# If SCREEN_WIDTH is not given, the entire terminal width is used
# If COLUMN_WIDTH is not given, the maximum number of columns are created

w=${2:-$(tput cols)}
DEFAULT_COLW=4
colw=${1:-$DEFAULT_COLW}
cols=$((w / (colw + 9))) # Correcting for slash width and divider width
n=0
d=1
skip=0
delay=0.02

print_dots () {
	for ((i=1; i<=$1; i++))
	do
		echo -n '.'
	done
}

print_slash () {
	if [ $1 -eq 1 ]
	then
		echo -n '  \  '
	else
		echo -n '  /  '
	fi
}


while true
do
	even_flag=0
	for ((coln=0; coln<=$cols; coln++))
	do
		if [ $even_flag -eq 0 ]
		then
			print_dots $n
			print_slash $d
			print_dots $((colw-n))
			even_flag=1
		else
			print_dots $((colw-n))
			print_slash $((-d))
			print_dots $n
			even_flag=0
		fi
		echo -n ' | '
	done
	echo ''


	if [ $n -eq $(($colw-1)) ] && [ $d -eq 1 ]
	then
		d=-1
		skip=1
	fi
	if [ $n -eq 0 ] && [ $d -eq -1 ]
	then
		d=1
		skip=1
	fi

	if [ $skip -eq 0 ]
	then
		n=$((n+d))
	else
		skip=0
	fi

	sleep $delay
done
