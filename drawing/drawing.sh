#!/bin/bash
NUM=0
echo -n "plese enter number between (5 to 9) : "
read NUM
#echo $NUM
if ! [ $NUM -ge 5 -a $NUM -le 9 ]; then
	echo "plese enter number between (5 to 9)."
	exit 1
fi
clear
for ((i=1;i<=$NUM;i++))
do
	for ((t=$NUM;t>=i;t--)) 
	do
		echo -n " "		
	done
#	echo " ."
	for ((s=1;s<=$i;s++))
	do
		echo -n " ."
	done
	echo ""
done
for ((i=1;i<$NUM;i++))
do
	for ((t=1;t<=($i+1);t++))
	do
		echo -n " "
	done
#	echo " ."
	for ((s=($NUM-1);s>=$i;s--))
	do
		echo -n " ."
	done
	echo ""
done 
echo -e "\n\t\t this is my demo."
exit 0
