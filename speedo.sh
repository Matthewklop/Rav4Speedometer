a=10
b=10
CanData="  99 99" #can to search with spaces | also double space at start "optional"
CanToSend="vcan0 100#0000000000000000"

while [ $a = $b ] 
do
#after grep put ID
spd=$(timeout 0.1s candump vcan0 | grep  "B4" | cut -d "]" -f2)	
printf "$spd"
# after = put data in quote
if [ "$spd" = "$CanData" ]; then
echo " !string found! "
cansend $CanToSend
fi
st=""
done



#cansend vcan0 01a#11223344AABBCCDD example
