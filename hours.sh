#! /bin/sh

if [[ $# -gt 3 ]]; then
	FIRST="0:00"
	SECOND="0:00"
	period1=$2
	period2=$4

	IFS=: read -r hour1 minute1 hour2 minute2 <<< "$1:$3"
	if [[ $hour1 -gt 12 || $minute1 -gt 59 || $hour2 -gt 12 || $minute2 -gt 59 ]]; then
		echo "Invalid input. Usage: ./hours.sh <9:00 AM> <10:00 AM>"
	else
	
		# check AM and PM, PM add 12 hours to first number
		if [[ ${period1^^} = "PM" ]]; then
			# split on the colon, add 12 to 1, combine again and continue
			IFS=: read -r hour minute <<< "$1"
			hour=$(calc $hour+12)
			FIRST=$hour:$minute
		else
			FIRST=$1
		fi
	
		if [[ ${period2^^} = "PM" ]]; then
			# split on the colon, add 12 to 1, combine again and continue
			IFS=: read -r hour minute <<< "$3"
			hour=$(calc $hour+12)
			SECOND=$hour:$minute
		else
			SECOND=$3
		fi
	
		echo $FIRST, $SECOND
		# subtract first from second
		IFS=: read -r firsthour firstmin <<< "$FIRST"
		IFS=: read -r secondhour secondmin <<< "$SECOND"
	
		difference=$(calc $firsthour-$secondhour)
	
		difference=$(echo $difference | sed 's/^[-]//')
	
		increase=1
	
		if [[ firstmin -gt 29 ]]; then
			if [[ firsthour > secondhour ]]; then
				# The hour is later, therefore add an hour.
				difference=$(calc $difference+$increase)
			else
				# The hour is earlier, therefore remove an hour.
				difference=$(calc $difference-$increase)
			fi
		fi
	
		if [[ secondmin -gt 29 ]]; then
			if [[ secondhour > firsthour ]]; then
				# the hour is later, therefore add an hour.
				difference=$(calc $difference+$increase)
			else
				# The hour is earlier, therefore remove an hour.
				difference=$(calc $difference-$increase)
			fi
		fi
	
		echo $difference
	fi
else
	echo "Usage: ./hours.sh <9:00 AM> <10:00 AM>"
fi
