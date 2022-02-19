#!/bin/bash
#
# This script produces a dynamic welcome message
# it should look like
#   Welcome to planet hostname, title name!

# Task 1: Use the variable $USER instead of the myname variable to get your name
# Task 2: Dynamically generate the value for your hostname variable using the hostname command - e.g. $(hostname)
# Task 3: Add the time and day of the week to the welcome message using the format shown below
#   Use a format like this:
#   It is weekday at HH:MM AM.
# Task 4: Set the title using the day of the week
#   e.g. On Monday it might be Optimist, Tuesday might be Realist, Wednesday might be Pessimist, etc.
#   You will need multiple tests to set a title
#   Invent your own titles, do not use the ones from this example

###############
# Variables   #
###############
title="Overlord"
myname=$USER
hostname=$HOSTNAME
weekday=$(date +%A)
hour=$(date +%r)
###############
# Main        #
###############
if [ "$weekday" = "Monday" ]; then
	title=Monday
elif [ "$weekday" = "Tuesday" ]; then
	title=Tuesday
elif [ "$weekday" = "Wednesday" ]; then
	title=Wednesday
elif [ "$weekday" = "Thursday" ]; then
	title=Thursday
elif [ "$weekday" = "Friday" ]; then
	title=Friday
elif [ "$weekday" = "Saturday" ]; then
	title=Saturday
elif [ "$weekday" = "Sunday" ]; then
	title=Sunday
else
echo "no such weekday"
fi


export welcome_output=$(cat <<EOF
Welcome to planet $hostname, $title $myname!  
It is $weekday at $hour
EOF
) ;

cowsay $welcome_output

