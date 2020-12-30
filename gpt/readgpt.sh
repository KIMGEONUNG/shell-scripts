#!/bin/bash

# init variables
file="./gpt-dump"
entry=$((512 * 0))
len=0
off=0
empty=$(printf '\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1\1')

#----------------------------------------------------------------------------------------------
echo "#LAB 0(LOGICAL ADDRESS BLOCK): PROTECTIVE MBR(MASTER BOOT RECORD)"
echo 
len=512

echo " hex    :     " 
hexdump -C $file -s $(($off + $entry)) -n $len -v | head -n -1 | sed "s:^[^ ]\{8\} ::"
echo

#----------------------------------------------------------------------------------------------
echo "#LAB 1: GPT HEADER"
echo 

entry=$((512 * 1))
offs=(0 8 12 16 20 24 32 40 48 56 72 80 84 88 92)
bts=(8 4 4 4 4 8 8 8 8 16 8 4 4 4 420)
details=("Signature (EFI PART, 45h 46h 49h 20h 50h 41h 52h 54h or 0x5452415020494645ULL[a] on little-endian machines)" "Revision 1.0 (00h 00h 01h 00h) for UEFI 2.8" "Header size in little endian (in bytes, usually 5Ch 00h 00h 00h or 92 bytes)" "CRC32 of header (offset +0 up to header size) in little endian, with this field zeroed during calculation" "Reserved; must be zero" "Current LBA (location of this header copy)" "Backup LBA (location of the other header copy)" "First usable LBA for partitions (primary partition table last LBA + 1)" "Last usable LBA (secondary partition table first LBA − 1)" "Disk GUID in mixed endian[7]" "Starting LBA of array of partition entries (always 2 in primary copy)" "Number of partition entries in array" "Size of a single partition entry (usually 80h or 128)" "CRC32 of partition entries array in little endian" "Reserved, must be zeroes for the rest of the block (420 bytes for a sector size of 512 bytes; but can be more with larger sector sizes)")

for i in {0..14}
do
    off=${offs[$i]}
    len=${bts[$i]}
    detail=${details[$i]}

    echo $detail
    echo " offset : $off"
    echo " length : $len"
    echo " hex    :     " 
    hexdump -C $file -s $(($off + $entry)) -n $len -v | head -n -1 | sed "s:^[^ ]\{8\} ::"
    echo 
done

#----------------------------------------------------------------------------------------------

for i in {2..33}
do
    echo "#LAB $i"
    echo 

    entry=$((512 * $i))
    offs=(0 16 32 40 48 56)
    bts=(16 16 8 8 8 72)
    details=("Partition type GUID (mixed endian[7])" "Unique partition GUID (mixed endian)" "First LBA (little endian)" "Last LBA (inclusive, usually odd)" "Attribute flags (e.g. bit 60 denotes read-only)" "Partition name (36 UTF-16LE code units)")

    for j in {0..3}
    do
        echo "##ENTRY $(($j + 1 + 4 * $i - 8))"

        entry_sub=$(($entry + 128 * $j))

        for k in {0..5}
        do
            off=${offs[$k]}
            len=${bts[$k]}
            detail=${details[$k]}

            if [[ $k == 0 ]]; then
                bin_data=$(dd if=$file skip=$(($off + $entry_sub)) count=$len bs=1 2>/dev/null | tr '\0' '\1')
                if [[ $bin_data == $empty ]]; then
                    echo " empty entry "
                    break
                fi
            fi

            echo $detail
            echo " offset : $off"
            echo " length : $len"
            echo " hex    :     " 
            #hexdump -C $file -s $(($off + $entry_sub)) -n $len -v | head -n -1 | sed "s:^[^ ]\{8\} ::"
            hexdump -C $file -s $(($off + $entry_sub)) -n $len -v | head -n -1
            echo 
        done
        echo 
    done
done
