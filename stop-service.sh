#!/bin/bash

if [ $# -lt 1 ];
then
	echo "Usage $0 <service name>"
	exit 1;
fi

echo "Checking for $1 process..."
ps -ef | grep $1.jar | grep -v grep
if [ "$?" = "1" ]
then
	echo "$1 process is not running!"
else
	pid=$(ps -ef | grep $1.jar | grep -v grep | awk '{print $2}')
	if [[ -z "$pid" ]]
	then
		echo "Error: Invalid process ID $pid!"
	else
		echo "Killing process with ID: $pid..."
		kill -9 "$pid" >&-
		if [ "$?" = "1" ]
		then
			echo "Error: Failed to kill process with ID: $pid!"
			exit 1;
		else
			echo "Checking process with ID: $pid..."
			sleep 3;
			ps -p "$pid"
			if [ "$?" = "0" ]
			then
				echo "Error: Failed to kill process with ID: $pid!"
				exit 1;
			else
				echo "Successfully stopped $1."
			fi
		fi
	fi
fi

