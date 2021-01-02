if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ "$#" -ne 1 ]
  then 
  echo "Give me the device path as first argument"
  exit
fi

block_size=4096
o_name="./inode-table.bin"
device=$1
ranges=$(dumpe2fs $device 2>/dev/null | grep "Inode table" | sed "s:.\+\ \([0-9]\+-[0-9]\+\).\+:\1:")
ranges_arr=($ranges)
len=${#ranges_arr[@]}

rm $o_name 2> /dev/null

for range in $ranges
do
    from=${range%-*}
    to=${range#*-}

    dd if=$device bs=$block_size count=$(($to - $from + 1)) skip=$from >> $o_name
done
