if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ "$#" -ne 1 ]
  then 
  echo "Give me the device path as first argument"
  exit
fi

device=$1
o_name="./inode-table.bin"

block_size=$(sudo dumpe2fs /dev/nvme0n1p5 2>/dev/null | grep "Block size" | sed "s:.*\ \([0-9]\+\)\ *:\1:")
ranges=$(dumpe2fs $device 2>/dev/null | grep "Inode table" | sed "s:.\+\ \([0-9]\+-[0-9]\+\).\+:\1:")
ranges_arr=($ranges)
len=${#ranges_arr[@]}

rm $o_name 2> /dev/null

for range in $ranges
do
    from=${range%-*}
    to=${range#*-}

    dd if=$device bs=$block_size count=$(($to - $from + 1)) skip=$from 2>/dev/null >> $o_name
done
