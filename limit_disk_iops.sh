#!/bin/bash

bash python /root/iops-limit/set_disk_io_bps.py set 51228800
ssh slave1 "python /root/iops-limit/set_disk_io_bps.py set 51228800"
ssh slave2 "python /root/iops-limit/set_disk_io_bps.py set 51228800"
ssh slave3 "python /root/iops-limit/set_disk_io_bps.py set 51228800"
ssh slave4 "python /root/iops-limit/set_disk_io_bps.py set 51228800"
ssh slave5 "python /root/iops-limit/set_disk_io_bps.py set 51228800"
