#/bin/bash
outputhome=/home/cpustatus_output
function output()
{		
	hour=`date +%Y%m%d-%H`
	date=`date +%Y-%m-%d-%T`
	mkdir -p $outputhome/$hour
	cd $outputhome/$hour
	$date >> top.log
	top -n 1 -b  >> top.log 
	sleep 10
}

while(true)
do
us=`top -b -n 1 | grep Cpu | awk '{print $2}' | cut -f 1 -d "."`
[ $us -ge 40 ] && output
done
