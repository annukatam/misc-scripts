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
	CONNECTED=true
	echo "$(date +'%d/%m/%Y %H:%M:%S:%3N')" "the internet connection is available."
else
	CONNECTED=false
	say "no internet connection."
fi


# endless loop
while true
do

	if ping_func
	then
		if [ $CONNECTED == false ]
		then
			echo "$(date +'%d/%m/%Y %H:%M:%S:%3N')" "the internet connection was restored."
		fi
		CONNECTED=true;
	else
		if [ $CONNECTED == true ]
		then
			let "LOST_COUNT += 1"
			echo "$(date +'%d/%m/%Y %H:%M:%S:%3N')" "the internet connection was lost."
		fi
		CONNECTED=false;
	fi

	echo "$(date +'%d/%m/%Y %H:%M:%S:%3N')" "connection status -> " $CONNECTED " lost count -> " $LOST_COUNT
	sleep 1
done
