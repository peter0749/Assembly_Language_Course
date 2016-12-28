#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin

S_mean=0
W_mean=0
for i in {1..12}
do
    echo "case: $i"
    t1=`./tmp1.bin data.txt`
    S_mean=$S_mean+$t1
    echo -e "Serial:\n${t1}us"
    t2=`./tmp2.bin data.txt $i`
    W_mean=$W_mean+$t2
    echo -e "OMP+SIMD($i threads):\n${t2}us\n"
done
echo "Avg serial: ${t1}us"
echo "Avg OMP+SIMD: ${t2}us"

