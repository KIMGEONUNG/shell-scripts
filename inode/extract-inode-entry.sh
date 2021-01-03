if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ "$#" -ne 2 ]
  then 
  echo "Give me device path and inode number as arguments"
  exit
fi

device=$1
index=$2

o_name="./inode-table.bin"
size_inode_entry=$(dumpe2fs $device 2>/dev/null | grep "Inode size" | sed "s:.*\ \([0-9]\+\)\ *:\1:")

block_size=$(dumpe2fs $device 2>/dev/null | grep "Block size" | sed "s:.*\ \([0-9]\+\)\ *:\1:")
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

dd if=$o_name bs=$size_inode_entry count=1 skip=$(($index - 1)) > "inode-$index.bin" 
