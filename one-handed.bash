#!/bin/bash

#LICENSE: Gnu GPL v3.0
declare -r LICENSE="GPL v3.0"

#this script is for single-handed typing
# It lets you use shift to flip the keyboard, as if viewed by a mirror
# It also means that everything you type has to be lower-case, and the
# shift key only works as a mirroring indicator, but hey, this is free,
# and those one-handed keyboards cost hundreds ^__^

#EXAMPLE: If you want to write "hello world" using only the left hand, you
# would write GeSSW wWrSd

#The script doesn't allow for any editing or even backspace, but the good news
# is that the backspace character gets written out to the file. So what you
# can do is run:
#     sed 's/.^?//g' filename > newfile
# to process the backspace characters for you
#NOTE that the ^? characters above are not the caret and question mark,
# but a visual indicator of the delete symbol. You get this on the
# command line by pressing CTRL-v, then the delete key (without control)

#Issue: the read -N option requires a recent version of bash. It work under
# bash 5.0.0, but not under bash 3.x.x. YMMV

#See if a filename was specified
if [ -z "$1" ]
then
	#Get a temp filename from the system (picks a random filename under /tmp)
	temp=`mktemp`
	echo "(You may specify a filename as the first commandline parameter."
	echo " Using tmp file instead)"
else
	#Use the filename provided
	temp=$1
fi

echo "Appending to $temp"
echo "Type zzz (or <<<) to exit"

#prev1 and 2 keep track of the last two characters, so we can trap for zzz
prev1=
prev2=

#read one character at a time, but suppress printing anything
while read -sN1 char
do
	if [ -z "$char" ]
	then
		#if the character read is empty, spit out a new line, otherwise...
		echo |tee -a $temp
	else
		#Pass the character through tr to handle the mirroring. Use tee to
		#  write out to the screen while appending to the file at the same time
		#(The single command is split out into multiple lines for readability,
		#   so the backslash *must* be the last character in the lines being
		#   continued)
		echo -n "$char" \
			|tr "QWERTYUIOPASDFGHJKL:ZXCVBNM<>?" "poiuytrewq;lkjhgfdsa/.,mnbvcxz" \
			|tee -a $temp
	fi

	#Process the exit command
	#manually mirror the comma to a z, because we don't save anything to a 
	#  variable when we're mirroring up above
	[ "$char" = "," ] && char=z

	#Cascade $char -> $prev1 -> $prev2
	prev2="$prev1"
	prev1="$char"
	#exit quietly if the last three characters given were "z" (or the mirror
	#  equivalent, ",")
	if [ "$char" = "z" ] && [ "$prev1" = "z" ] && [ "$prev2" = "z" ]
	then
		echo
		exit
	fi
done
