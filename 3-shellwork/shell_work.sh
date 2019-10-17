#!/bin/bash
ay=(saa dsfdsgv sdgvsv sdgsg hheh 6544 sFgbsb)
echo "ay lenth ${#ay[*]}"
for ay_str in ${ay[*]}
do
    echo  $ay_str
done

ay1=([0]=sdfsf [1]=dsffsadfas [2]=3455411)
for ((i=0;i<${#ay1[*]};i++))
do
    echo  ${ay1[i]}
done
