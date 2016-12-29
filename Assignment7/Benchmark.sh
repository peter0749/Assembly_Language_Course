#!/bin/bash
PATH=/bin:/usr/bin:/usr/local/bin:/sbin:/usr/sbin

for i in {1..32}
do
    echo "case: $i"
    t1=`./tmp1.bin data.txt`
    echo -e "Serial:\n${t1}us"
    t2=`./tmp2.bin data.txt $i`
    echo -e "OMP+SIMD($i threads):\n${t2}us\n"
done

