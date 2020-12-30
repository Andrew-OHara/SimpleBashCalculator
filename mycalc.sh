#!/bin/bash
# Lab 9
# Andrew O'Hara  040992043
# mycalc.sh
# 2020-11-05
# This script file performs math using functions

function add {
	echo $(($1 + $2))
}

function subtract {
    echo $(($1 - $2))
}

function openMenu {
	echo "C) Calculation"
	echo
	echo "X) Exit"
}

function mathMenu {
	echo "+) Add"
	echo
	echo "-) Subtract"
	echo
	echo "X) Exit"
}

function notifyBadInput {
	echo
	echo "Choice not valid! Please select again"
	echo
	sleep 3
}


if [[ $# -lt 1 ]]; then 
	# there are no command line args, proceed into prompt mode
    
    choice=""  #initialize choice to invalid value
    while [[ "$choice" != "X" && "$choice" != "x"  ]];
	do clear
	  	openMenu
	   	read choice

	   	if [[ "$choice" = "X" || "$choice" = "x" ]]; then
	   		exit
	   	elif [[ "$choice" = "C" || "$choice" = "c" ]]; then	   		    	
	   		clear
	   		read -p "Please enter an integer number or X to exit:" first_num
	   		if [[ "$first_num" = "X" || "$first_num" = "x" ]]; then
	   			exit
	   		fi   		
	   		# this loop only runs if we haven't exited
	   		op_choice=""	#ensure loop runs the first time
	   		while [[ "$op_choice" != "+" && "$op_choice" != "-" && "$op_choice" != "X" && "$op_choice" != "x" ]];
	   		do clear
	   			# present math menu and get user choice
	   			mathMenu
	   			read op_choice	 
	   			if [[ "$op_choice" = "X" || "$op_choice" = "x"  ]]; then
	   				exit
	   			elif [[ "$op_choice" = "+" || "$op_choice" = "-" ]]; then
	   				# exit not chosen, get second number from user
	   				clear
	   				read -p "Please enter an integer number or X to exit:" second_num
	   				if [[ "$second_num" = "X" || "$second_num" = "x" ]]; then
	   					exit
	   				fi
	   				if [[ "$op_choice" = "+" ]]; then
	   					# perform addition and ouput result
	   					echo -n "The sum of $first_num plus $second_num equals "
	   					echo $(add $first_num $second_num)
	   				else
	   					 # perform subtraction an output result
	   					echo -n "The difference of $first_num minus $second_num equals "
	   					echo $(subtract $first_num $second_num)
	   				fi
	   				sleep 3

	   			else
	   				notifyBadInput
	   			fi
	   		done	   		
    	else
    		notifyBadInput
    	fi
	done   
# check if there were three parameters
elif [[ $# -eq 3 ]]; then
	# use pattern matching with regex to ensure integer values for $1 and $3
	if [[ "$1" =~ ^-?[0-9]+$ && "$3" =~ ^-?[0-9]+$ ]]; then
    	if [[ "$2" = "+" ]]; then
    		echo -n "The sum of $1 plus $3 equals "
		   	echo $(add $1 $3)
		elif [[ "$2" = "-" ]]; then
			echo -n "The difference of $1 minus $3 equals "
		   	echo $(subtract $1 $3)
		# if the second character was anything other than + or -, output a message to user
		else
			echo "usage : ./mycalc.sh 'number' +/- 'number' : Second argument must be + or -"
		fi
	else
		echo "usage : ./mycalc.sh 'number' +/- 'number' : Both numbers must be integers"
	fi
else 
    echo "usage : ./mycalc.sh 'number' +/- 'number' : use three arguments or zero for interactive mode"
fi