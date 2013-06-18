#!/bin/bash
if [ -n "$1" ] 
then
	cat BIOS.np | curl -X PUT -d @- http://$1/setBIOS
else
	echo "Usage: setBIOS.sh 192.168.0.22"
fi
