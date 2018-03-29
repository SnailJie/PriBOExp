#!/bin/bash
if (($# < 6));then
        echo -e "Usge: Please input --cpu --ram --diskType --netType --count --programName.\n --diskType 1:limit 0:unlimit  \n --netType 1:limit 0: unlimit"
        exit 1
fi

cpu=$1
ramv=$2 
diskType=$3
netType=$4
count=$5
programName=$6
echo -e "Input configuration   \n cpu: $cpu,ram = $ram,diskType = $diskType,netType = $netType,count = $count "

SPARK_PATH=$SPARK_HOME
SPARK_CONF_PATH=$SPARK_HOME/conf

bash $SPARK_PATH/sbin/stop-all.sh
cat /dev/null > $SPARK_CONF_PATH/slaves
for((i=1;i<=$count;i++));
do
echo slave$i >> $SPARK_CONF_PATH/slaves
done
bash $SPARK_PATH/sbin/start-all.sh

bash unlimit_iops.sh

if(($diskType==1));then
        bash limit_disk_iops.sh
fi

if(($netType==1));then
        bash limit_network_iops.sh
fi

PG_PATH=/opt/spark-bench/$programName

cp $PG_PATH/run.sh $PG_PATH/bin
sed -i "s/ramvalue/$ramv/g" $PG_PATH/bin/run.sh
sed -i "s/cpuvalue/$cpu/g" $PG_PATH/bin/run.sh
((test=$cpu*$count))
sed -i "s/totalCPU/$test/g" $PG_PATH/bin/run.sh

bash $PG_PATH/bin/run.sh
echo "RUN SCUESS"

