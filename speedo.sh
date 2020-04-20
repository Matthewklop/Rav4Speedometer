a=10
b=10
st=00
CanToSend="can0 399#0000000000000000"

while [ $a = $b ] 
do
spd=$(timeout 0.1s candump can0 | grep  "B4" | cut -d "]" -f2 | cut -b 12-13)
CanSend="can0 399#000000" + "$st" +"00000000"
printf "$spd"
done

#cansend can0 01a#11223344AABBCCDD --example
