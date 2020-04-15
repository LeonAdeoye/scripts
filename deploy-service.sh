#!/bin/bash

if [ $# -lt 1 ];
then
	echo "Usage $0 <service name>"
	exit 1;
fi

clear

echo "Firstly, stopping $1..."
./stop-service.sh $1

echo "Next, copying $1 jar file from micro-service's target folder to the bin folder..."
cp ../$1/target/$1-*.jar ../bin/$1.jar
if [ "$?" = "0" ]
then
	echo "Successfully copied $1 jar file to bin folder."
else
	echo "Failed to copy $1 jar file to bin folder!"
fi

echo "Lastly, starting $1..."
./start-service.sh $1
