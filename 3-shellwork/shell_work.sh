#!/bin/bash

for n in {1..25}
do
    echo -n  " $n"
done

for n in {a..z}
do
    echo -n " $n"
done

for n in 25 45 89 15 78
do
    echo "$n"
done

for (( i=0;i<10;i++ ))
do
    echo "$i"
done

while [ 5 -eq 5 ]
do
    echo "AAA"
    exit 12
done
