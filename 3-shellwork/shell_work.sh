#!/bin/bash
test_str="lbgn bgflv sbgrwgffmwghwv dav jwefffefnfvsvbsajfba"
echo "test_str =  $test_str"
echo "test_str lenth = ${#test_str}"
echo "test_str offset 12 str = ${test_str:12}"
echo "test_str offset 12-14 str =${test_str:12:14}"
echo "test_str start rm short l*g str =${test_str#l*g}"
echo "test_str start rm long l*g str =${test_str##l*g}"
echo "test_str end  rm short b*a str =${test_str%b*a}"
echo "test_str end  rm long  b*a str =${test_str%%b*a}"
echo "test_str change first str f/a  =${test_str/f/a}"
echo "test_str change all  str f/a  =${test_str//f/a}"