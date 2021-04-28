#!/bin/sh

HOST=www.google.com
LOST_COUNT=0;

ping_func(){
	results=$(/sbin/ping -i0.1 -s0 -t2 -o $HOST &> /dev/null)
	return $?
}

# first initiate the values
if ping_func
then
	CONNECTION=up
	echo "$(date +'%d/%m/%Y %H:%M:%S:%3N')" "the internet connection is UP."
else
	CONNECTION=down
	echo "$(date +'%d/%m/%Y %H:%M:%S:%3N')" "the internet connection is DOWN."
fi


# endless loop
while true
do

	if ping_func
	then
		if [ $CONNECTION == down ]
		then
			echo "$(date +'%d/%m/%Y %H:%M:%S:%3N')" "the internet connection was restored."
		fi
		CONNECTION=up;
	else
		if [ $CONNECTION == up ]
		then
			let "LOST_COUNT += 1"
			echo "$(date +'%d/%m/%Y %H:%M:%S:%3N')" "the internet connection was lost."
		fi
		CONNECTION=down;
	fi

	echo "$(date +'%d/%m/%Y %H:%M:%S:%3N')" "connection status -> " $CONNECTION " lost count -> " $LOST_COUNT
	sleep 0.4
done
