#!/bin/bash

if [ $# -lt 1 ];
then
	echo "Usage $0 <service name>"
	exit 1;
fi

echo "Checking for $1 process..."
ps -ef | grep $1.jar | grep -v grep
if [ "$?" = "0" ]
then
	echo "$1 process is running! Use the stop-service.sh script to terminate it first."
else
	echo "Starting $1..."
	cd ../bin/
	java -Xms1g -Xms2g -jar $1.jar 2>&1 &
	ps -ef | grep $1.jar | grep -v grep
	if [ "$?" = "0" ]
	then
        	echo "Successfully started $1."
	else
		echo "Error: Failed to start $1."
		exit 1;
	fi
fi

