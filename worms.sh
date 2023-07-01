#!/bin/bash

COLS=${1:-$(tput cols)}
SEP=' '
prev2=''
prev=''
cur=''
p=128
p_live=32
p_birth=1
sleep=0.2

while true
do
	for  ((i=1;i<$COLS;i++))
	do
		rand=$(($RANDOM % $p))
		last_char=${prev:$((i-1)):1}
		2nd_last_char=${prev2:$((i-1)):1}
		nb=0
		if [ "$last_char" == "/" ]
		then
			if [ $rand -gt $p_live ] || [ $nb -eq 1 ]
			then
				cur="$cur$SEP"
				nb=0
			else
				cur="$cur\\"
				nb=1
			fi
		elif [ "$last_char" == "\\" ]
		then
			if [ $rand -gt $p_live ] || [ $nb -eq 1 ]
			then
				cur="$cur$SEP"
				nb=0
			else
				cur="$cur/"
				nb=1
			fi
		else
			if [ $rand -gt $p_birth ] || [ $nb -eq 1 ]
			then
				cur="${cur}$SEP"
				nb=0
			elif [ $rand -le $p_birth ] && [ $((rand % 2)) -eq 0 ]
			then
				cur="${cur}/"
				nb=1
			elif [ $rand -le $p_birth ] && [ $((rand % 2)) -eq 1 ]
			then
				cur="${cur}\\"
				nb=1
			else
				echo "UNEXPECTED RANDOM $rand"
			fi
		fi
	done
	printf "$cur\n"
	prev2=$prev
	prev=$cur
	cur=''
	sleep $sleep
done
