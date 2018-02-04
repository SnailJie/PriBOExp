#!/bin/bash

bash /root/iops-limit/tcscript.sh start eth0 800mbit 800mbit
ssh slave1 "bash /root/iops-limit/tcscript.sh start eth0 800mbit 800mbit"
ssh slave2 "bash /root/iops-limit/tcscript.sh start eth0 800mbit 800mbit"
ssh slave3 "bash /root/iops-limit/tcscript.sh start eth0 800mbit 800mbit"
ssh slave4 "bash /root/iops-limit/tcscript.sh start eth0 800mbit 800mbit"
ssh slave5 "bash /root/iops-limit/tcscript.sh start eth0 800mbit 800mbit"
