#!/bin/sh

URL='https://www.accuweather.com/en/us/chicago-il/60608/weather-forecast/348308'

wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $12 }'| head -1 > /tmp/temp.txt

chmod 777 /tmp/temp.txt


##################################
#####WeATHER CHECK################
##################################
temp=$(cat /tmp/temp.txt)
if [ "$temp" -gt 60 ]; then

python ~/LED3x.py

exit 0

else

echo "Dog cold warning"


fi

exit 0



