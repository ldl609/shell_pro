#!/bin/bash
filepath=$1
for filename in `ls  $filepath`
do
    echo `echo "$filename"|cut -d . -f1`
done

