#!/bin/sh

URL='https://www.accuweather.com/en/us/chicago-il/60608/weather-forecast/348308'

wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $12 }'| head -1 > /tmp/temp.txt

chmod 777 /tmp/temp.txt


##################################
#####WeATHER CHECK################
##################################
temp=$(cat /tmp/temp.txt)
echo The temperature is $temp degrees.

if [ "$temp" -gt 60 ]; then

python ~/LED3x.py

echo No action required. 

exit 0

else

echo "Dog cold warning"

mailform=/tmp/1form.txt
myemail=BLANK@gmail.com
####################################
#The email magic####################
####################################
echo "To: $myemail" > $mailform
echo "From: $myemail" >> $mailform
echo "Subject: Outside temp cold warning! It is" $temp "degrees">> $mailform
cat $mailform | ssmtp $myemail

rm $mailform

python ~/LEDon.py

exit 0
fi

exit 0





