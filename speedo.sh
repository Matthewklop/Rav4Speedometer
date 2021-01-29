#! /bin/bash


while [$a = $a]
do
#Grabs current UI data
grabcan=$(timeout 10 candump -n 1 vcan0,399:DFFFFFFF | cut -d "]" -f2)
#get rid of spaces
spd=${grabcan//[[:blank:]]/}
#remove can ID for CANSEND
a2=$(echo $spd | cut -b 9-16)



#Grabs speed data
dirtycan=$(timeout 10 candump -n 1 vcan0,0B4:DFFFFFFF | cut -d "]" -f2)
oldcan=${dirtycan//[[:blank:]]/}
#edit these to change individual can numbers
#b1=$(echo $oldcan | cut -b 1-2)
#b2=$(echo $oldcan | cut -b 3-4)
#b3=$(echo $oldcan | cut -b 5-6)
#b4=$(echo $oldcan | cut -b 7-8)
#b5=$(echo $oldcan | cut -b 9-10)
#b6=$(echo $oldcan | cut -b 11-12)
#b7=$(echo $oldcan | cut -b 13-14)
#b8=$(echo $oldcan | cut -b 15-16)
speed=$(echo $oldcan | cut -b 11-14)
#convert kph hex speed to mph hex speed
cleanspeed=$(bash h2d.sh $speed)
mph=$(echo "$cleanspeed*0.00621371" | bc)
shortmph=$(echo $mph | cut -b 1-2)
hexmph=$(bash d2h.sh $shortmph)
clear
echo "$hexmph"
hexCount=$(echo -n "$hexmph" | wc -c)
#this fixes problem with dissapearing 0
if [[ "$hexCount" -gt "1" ]]; then
echo "yes"
space=$(echo "")
else
space=$(echo "0")
echo "no"
fi
echo "$space$hexmph"
#the toyota UI update happens every second so it sends the command 3 times in one second for max updates
cansend can0 399#102500$space$hexmph$a2
sleep 0.3
cansend can0 399#102500$space$hexmph$a2
sleep 0.3
cansend can0 399#102500$space$hexmph$a2
sleep 0.3
cansend can0 399#102500$space$hexmph$a2
done

