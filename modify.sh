#!/bin/bash


#===================get input ============

if (($# < 5));then
        echo -e "Usge: Please input --cpu --ram --diskType --netType --count.\n --diskType 1:limit 0:unlimit  \n --netType 1:limit 0: unlimit"
        exit 1
fi

cpu=$1
((ram=$2*1024))
diskType=$3
netType=$4
count=$5
echo -e "Input configuration   \n cpu: $cpu,ram = $ram,diskType = $diskType,netType = $netType,count = $count "


#==================modify hadoop============
hadoop_path=$HADOOP_HOME
hadoop_conf_path=$hadoop_path/etc/hadoop
echo "Hadoop Path is $hadoop_path"

#-----------replace ram----------

cp yarn-site.xml $hadoop_path/etc/hadoop
sed -i "s/ramvalue/$ram/g" $hadoop_conf_path/yarn-site.xml
sed -i "s/cpuvalue/$cpu/g" $hadoop_conf_path/yarn-site.xml
 
#===================== deploy yarn file==========
 
for((i=1;i<=$count;i++));
do 
scp $hadoop_conf_path/yarn-site.xml slave$i:$hadoop_conf_path
done

bash $hadoop_path/sbin/stop-all.sh
sleep 10s
#=====================modify slave==========================
cat /dev/null > $hadoop_conf_path/slaves  
for((i=1;i<=$count;i++));
do 
echo slave$i >> $hadoop_conf_path/slaves
done

#limit IO and network

bash unlimit_iops.sh

if(($diskType==1));then
	bash limit_disk_iops.sh
fi

if(($netType==1));then
	bash limit_network_iops.sh
fi



# restart cluster
bash $hadoop_path/sbin/start-all.sh
echo "Redeploy over"
