#!/bin/bash


#===================get input ============

echo "Please input -cpu -ram -diskType -netType -count"
cpu=$1
ram=$2
diskType=$3
netType=$4
count=$5
echo -e "Input configuration   \n cpu: $cpu,ram = $ram,diskType = $diskType,netType = $netType,count = $count "

#==================modify hadoop============
hadoop_path=$HADOOP_HOME
echo "Hadoop Path is $hadoop_path"

#-----------replace ram----------

num1=`awk '/yarn.scheduler.maximum-allocation-mb/{print NR+1}' yarn-site.xml`
sed -e "$num1 s/\d+/$ram/" yarn-site.xml

num2=`awk '/yarn.nodemanager.resource.memory-mb/{print NR+1}' yarn-site.xml`
sed -e "$num2 s/\d+/$ram/" yarn-site.xml

#---------replace cpu------------

num3=`awk '/yarn.scheduler.maximum-allocation-vcores/{print NR+1}' yarn-site.xml`
sed -e "$num3 s/\d+/i/" yarn-site.xml

num4=`awk '/yarn.nodemanager.resource.cpu-vcores/{print NR+1}' yarn-site.xml`
sed -e "$num4 s/\d+/i/" yarn-site.xml


#===================== deploy yarn file==========
scp yarn-site.xml slave1:`pwd`

for 
