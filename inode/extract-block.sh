if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ "$#" -ne 2 ]
  then 
  echo "Give me device path and block address as arguments"
  exit
fi

device=$1
add_block=$2

dd if=$device bs=4096 count=1 skip=$(($add_block)) 2>/dev/null | hexdump -C 

