#!/bin/bash

FUN=$1
NAME=$2
NUM=$3

case $FUN in
	"new")
		if [[ $NUM =~ ^[0-9]{3}-[0-9]{3}-[0-9]{4}$ ]] && [[ $NAME =~ "* *" ]]; then
	        	echo "$NAME $NUM" >> book.txt
		elif [[ $NUM =~ ^[0-9]{3}-[0-9]{3}-[0-9]{4}$ ]]; then
			
			echo "Please enter full name(first and last)!" 
		else
	        	echo "Incorrect phonenumber!"
		fi;;
	"list")
		if [ -s book.txt ]; then
			cat book.txt
		else
			echo "Phonebook is empty"
		fi;;
	"remove")
		sed -i "/$NAME/d" book.txt;;
	"clear")
		rm -rf book.txt;;
	"lookup")
		sed -n "/$NAME/p" book.txt > tem.txt 
		awk '{print $3}' tem.txt
		rm -fr tem.txt;;
		#another way to do :
                #sed -n "s/.*$NAME \([0-9]\{3\}-[0-9]\{3\}-[0-9]\{4\}\).*/\1/p" book.txt 
	*)
		echo "Incorrect input!";;
	esac

		
