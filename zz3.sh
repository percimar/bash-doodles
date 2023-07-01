#!/bin/bash

w=${1:-$(tput cols)}
w=$(($w-26))
otw=$(($w/3))
n=0
d=1
skip=0
delay=0.01

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
	print_dots $n
	print_slash $d
	print_dots $(($otw-$n))
	echo -n ' | '
	print_dots $(($otw-$n))
	print_slash $((-$d))
	print_dots $n
	echo -n ' | '
	print_dots $n
	print_slash $d
	print_dots $(($otw-$n))
	echo ''


	if [ $n -eq $(($otw-1)) ] && [ $d -eq 1 ]
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
