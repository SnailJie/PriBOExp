#!/bin/bash

bash /root/iops-limit/tcscript.sh stop eth0 && python /root/iops-limit/set_disk_io_bps.py set 0
ssh slave1 "bash /root/iops-limit/tcscript.sh stop eth0 && python /root/iops-limit/set_disk_io_bps.py set 0"
ssh slave2 "bash /root/iops-limit/tcscript.sh stop eth0 && python /root/iops-limit/set_disk_io_bps.py set 0"
ssh slave3 "bash /root/iops-limit/tcscript.sh stop eth0 && python /root/iops-limit/set_disk_io_bps.py set 0"
ssh slave4 "bash /root/iops-limit/tcscript.sh stop eth0 && python /root/iops-limit/set_disk_io_bps.py set 0"
ssh slave5 "bash /root/iops-limit/tcscript.sh stop eth0 && python /root/iops-limit/set_disk_io_bps.py set 0"
