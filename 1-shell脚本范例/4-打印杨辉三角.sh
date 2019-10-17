#!/bin/bash
can_cunt=$#
MAXLIN=0
can_one=$1
get_max_lines(){
    if [ ${can_cunt} -eq 0 ]
        then
            read -p "ple input MAX lines:" MAXLIN
            if [ ${#MAXLIN} -lt 1 ]
                then
                    echo "ple input somthing!"
                    get_max_lines
            fi
    else
            MAXLIN=$can_one
    fi

    expr $MAXLIN + 1 &>/dev/null
     
    if [ $? -ne 0 ]
        then
            echo "ple input number!"
            get_max_lines
    fi
    echo "seccessfuly!"
}

great_sanjiao(){
    echo "MAXLIN = $MAXLIN"
    lin=1
    while [ $lin -le  $MAXLIN ]
    do
        colum=1
        while [ $colum -le $lin ]
        do
            f=$[lin-1]
            g=$[colum-1]
            if [ $colum -eq $lin ] || [ $colum -eq 1 ] 
             then
                 declare SUM_${lin}_$colum=1
            else
                declare A=$[SUM_${colum}_$colum]
                declare B=$[SUM_${colum}_$g]
                declare SUM_${lin}_$colum=`expr $A + $B`
            fi
            echo -en $[SUM_${lin}_$colum]" "
            let colum++ #colum=colum+1
        done
        echo
        let lin++
    done
}
main(){
    get_max_lines
    great_sanjiao
}

main
