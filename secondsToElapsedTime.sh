#!/bin/bash

#Input seconds
input=8274

howMyDoing() {

inputSec="$1"

hours() {

h=$(echo ''"$inputSec"'/3600' | bc -l)
#2.29833333333333333333

if [[ $(echo "$h" | awk -F. '{ print $1 }') == "" ]]; then
    echo "0$h"
else
    echo "$h"
fi

}

minutes() {

m=$(echo '.'"$(hours | awk -F. '{ print $2 }')"'*60' | bc -l)
#17.89999999999999999980

if [[ $(echo "$m" | awk -F. '{ print $1 }') == "" ]]; then
    echo "0$m"
else
    echo "$m"
fi

}

seconds() {

s=$(echo 'scale=0; (.'"$(minutes | awk -F. '{ print $2 }')"'*60+0.005)/1' | bc -l)
#54

echo "$s"

}

tidyTime() {

time=$(echo "$(hours | awk -F. '{ print $1 }')":"$(minutes | awk -F. '{ print $1 }')":"$(seconds)")
#2:17:54

# Logic to capture those times time where there are  60 sec
if [[ $(echo $time | awk -F: '{ print $3}') == "60" ]]; then
	echo "$time" | awk -F: '{ print $1 ":" $2+1 ":0" }'
else
	echo "$time"
fi

}

echo "time spendt $(tidyTime)"

}

howMyDoing $input
#$ time spendt 2:17:54

exit $?
