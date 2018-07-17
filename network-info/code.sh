#!/bin/bash
#��ȡϵͳ��Ϣ
arch=`file /bin/bash |cut -d ' ' -f3`
sys=`cat /etc/klinux-release 2>/dev/null `
if [ $? -eq 1 ];then 
	sys="unknown system"
	echo "This system is not CGSL."
fi
echo "System : $sys $arch "
#��ȡatca-drivers�汾
ver=`/bin/rpm -qa |grep atca-drivers`
if [ $ver ]; then
	echo  "Driver package : $ver" 
else
	echo  "No such atca-drivers package installed."
fi
echo  ""
#��ȡ��ʶ����������
num=`/sbin/lspci |grep Eth |awk 'END{print NR}'`
#echo $num;
if [ $num == null -o $num -eq 0 ]; then
	echo "System does not discern network adapter."
	exit 0
fi
for ((i=1;i<=$num;i++ ))
	do
#��ȡPCI ID
		id=`/sbin/lspci |grep Eth |cut -d ' ' -f1 |sed -n "$i,1p"`
#��ȡAdapter Driver code
		code=`/sbin/lspci -n |grep $id |cut -d ' ' -f3 `
		des=`/sbin/lspci |grep Eth |cut -d : -f3 |awk "NR==$i{print}"`
		echo "Adapter : $i"
		echo "Description :$des"
		echo "Driver code : $code"
	done
exit 0
