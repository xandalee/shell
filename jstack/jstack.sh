#!/bin/bash  
  
########################################################  
### ����ռ��CPU��Դ���ߵ��߳���ϸ��Ϣ  
###   
### 2014-11-03 allen add  
### 2019-01-10 xanda modify  
###
##########################################################  

function output()
{
	#Step1 ��ӡռ��CPU���ߵĽ���ID  
	# top -b -d3 -n1 -u root | awk '/PID/,0' > /opt/logs/_pid_out.out  
	v_pid=$(top -b -d3 -n1 -u root | awk '/PID/,0' | awk 'NR==2 {print $1}')
	  
	#Step2 ��ӡ������ռ��CPU���ߵ��߳�ID  
	# top -b -d3 -n1 -H -p $v_pid | awk '/PID/,0' > ./_tid_out.out  
	v_tid=$(top -b -d3 -n1 -H -p $v_pid | awk '/PID/,0'| awk 'NR==2 {print $1}')
	  
	#Step3 ���߳�IDתΪ16����  
	#echo 'ibase=10;obase=16;$v_tid' | bc
	v_tid16=`printf %x $v_tid`  
	# echo "thread id[hexadecimal] is : 0x${v_tid16}"  
	# echo ""  
	  
	#Step4 ��ӡCPUռ�ù��ߵĽ��̵��߳�ջ  
	# echo "wait 5 seconds, please..."  
	jstack $v_pid >> /opt/logs/_thread_stack.out
	echo  -e "\n\n" >> /opt/logs/_thread_stack.out
	sleep 5s  
	  
	#Step5 �� _thread_stack.out �в����߳�ִ�еľ������,��ӡ���м���֮��30��,��������ʾƥ������  
	cat /opt/logs/_thread_stack.out | grep -n --color=auto -A 30 -i 0x${v_tid16} >> /opt/logs/_thread_stack_30.out
	echo  -e "\n\n\n" >> /opt/logs/_thread_stack_30.out
	  
	#clean  
	# rm -rf /opt/logs/_pid_out.out
	# rm -rf /opt/logs/_tid_out.out
}

# ����־����100MB���Զ�ɾ��
if [ -e "/opt/logs/_thread_stack_30.out" ];then
    fz=$(stat -c %s /opt/logs/_thread_stack.out)
    [ $fz -ge 104857600 ] && rm -rf /opt/logs/_thread_stack*.out
fi

us=`top -b -n 1 | grep Cpu | awk '{print $2}' | cut -f 1 -d "%"`
sys=`top -b -n 1 | grep Cpu | awk '{print $3}' | cut -f 1 -d "%"`
# total=$(echo $us+$sys |bc)
total=$(awk -v a=$us -v b=$sys 'BEGIN{printf "%.1f", a+b}')
[ $(expr $total \>= 90) -eq 1 ] && output
exit 0