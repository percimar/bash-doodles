#!/bin/bash

w=${1:-COLUMNS-5}
n=0
d=1


while true
do
	for ((i=1; i<=$n; i++))
	do
		echo -n '.'
	done

	if [ $d -eq 1 ]
	then
		echo -n '  \  '
	else
		echo -n '  /  '
	fi

	for ((i=1; i<=$w-$n-1; i++))
	do
		echo -n '.'
	done
	echo ''

	if [ $n -eq $(($w-1)) ]
	then
		d=-1
	fi
	if [ $n -eq 0 ]
	then
		d=1
	fi

	n=$((n+d))
	sleep 0.01
done
