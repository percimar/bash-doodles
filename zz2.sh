#!/bin/bash

w=${1:-$(tput cols)}
w=$(($w-13))
hw=$(($w/2))
n=0
d=1

print_dots () {
	for ((i=1; i<=$1; i++))
	do
		echo -n '.'
	done
}

print_slash () {
	if [ $n -eq 0 ] || [ $n -eq $(($hw-1)) ]
	then
		echo -n '  |  '
		return
	fi

	if [ $1 -eq 1 ]
	then
		echo -n '  \  '
	else
		echo -n '  /  '
	fi
}


while true
do
	print_dots $n
	print_slash $d
	print_dots $hw-$n
	echo -n ' | '
	print_dots $(($hw-$n))
	print_slash $((-$d))
	print_dots $n
	echo ''


	if [ $n -eq $(($hw-1)) ]
	then
		d=-1
	fi
	if [ $n -eq 0 ]
	then
		d=1
	fi

	n=$((n+d))
	sleep 0.005
done
