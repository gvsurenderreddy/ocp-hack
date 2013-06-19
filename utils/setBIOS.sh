#!/bin/bash
if [ -n "$1" ] 
then
	curl -X PUT -F BIOS=@"BIOS.np" http://$1:3000/setBIOS
else
	echo "Usage: setBIOS.sh 192.168.0.22"
fi
