#!/bin/sh

TEMP0_ROUNDED=1000
TEMP1_ROUNDED=1000
TEMP2_ROUNDED=1000

#Sometimes the values are not in the right "range" and needs to be read few times
while [ $TEMP0_ROUNDED -gt 50 ] || [ $TEMP0_ROUNDED -lt 5 ] ; do
  TEMP0=$(/usr/bin/digitemp_DS9097 -c/root/.digitemprc -t0 -q -s/dev/ttyUSB0 -o"%.2C")
  TEMP0_ROUNDED=`echo $TEMP0 | awk '{print int($1+0.5)}'`
done

while [ $TEMP1_ROUNDED -gt 50 ] || [ $TEMP1_ROUNDED -lt 5 ] ; do
  TEMP1=$(/usr/bin/digitemp_DS9097 -c/root/.digitemprc -t1 -q -s/dev/ttyUSB0 -o"%.2C")
  TEMP1_ROUNDED=`echo $TEMP1 | awk '{print int($1+0.5)}'`
done


while [ $TEMP2_ROUNDED -gt 50 ] || [ $TEMP2_ROUNDED -lt 5 ] ; do
  TEMP2=$(/usr/bin/digitemp_DS9097 -c/root/.digitemprc -t2 -q -s/dev/ttyUSB0 -o"%.2C")
  TEMP2_ROUNDED=`echo $TEMP2 | awk '{print int($1+0.5)}'`
done


/usr/bin/rrdtool update /data/mydigitemp/mydigitemp.rrd $(date +%s):$TEMP0:$TEMP1:$TEMP2
