#!/bin/bash
for((row=1;row<=9;row++))
do
    for((colum=1;colum<=$row;colum++))
    do
            echo  -en "\E[1;41m ${colum}x${row}=$[$row*$colum] \E[0m"
    done
    echo ""
done
