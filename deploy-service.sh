#!/bin/bash

if [ $# -lt 1 ];
then
	echo "Usage $0 <service name>"
	exit 1;
fi

clear

echo "Firstly, stopping $1..."
./stop-service.sh $1

echo "Getting latest version of code..."
cd ..

if [[ -d "$1" ]]
then
	echo "The folder $1 exists so using git pull to get the latest version of the code."
	cd ./$1/
	git pull origin master
else
	echo "The folder $1 does NOT exists so using git clone to get the latest version of the code."
	git clone https://github.com/LeonAdeoye/$1.git
	cd ./$1/
fi

echo "Building latest jar using maven..."
mvn clean package

echo "Next, copying $1 jar file from micro-service's target folder to the bin folder..."
cp ./target/$1-*.jar ../bin/$1.jar
if [ "$?" = "0" ]
then
	echo "Successfully copied $1 jar file to bin folder."
else
	echo "Failed to copy $1 jar file to bin folder!"
fi

echo "Lastly, starting $1..."
./../scripts/start-service.sh $1
