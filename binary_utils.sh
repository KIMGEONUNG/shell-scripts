binsert()
{
    #EXAMPLE 
    # binsert hello hello2 2 '\x61'

    input=$1
    output=$2
    start=$3
    str=$4
    num=`expr $start + 1`
    { head -c $start $input; printf $str; tail -c +$num $input; } > $output
}

# delete specific binary data
bdelete()
{
    input=$1
    output=$2
    start=$3
    count=$4
    end=`expr $start + $count`

    dd if=$input of=$output count=$start bs=1
    dd if=$input of=$output skip=$end seek=$start  bs=1
}
