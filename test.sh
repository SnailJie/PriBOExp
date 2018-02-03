#!/bin/bash
num1=`awk '/yarn.scheduler.maximum-allocation-mb/{print NR+1}' test.xml`
echo "line: $num1"
ram=11111111
sed -e "$num1 s/\d+/i/" test.xml
