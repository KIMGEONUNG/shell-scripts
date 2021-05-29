#!/bin/bash

# refer to: https://mincong.io/2018/04/28/git-index/#:~:text=The%20index%20is%20a%20binary,Git%3A%20they%20are%20used%20interchangeably.

targetfile=".git/index"

header=`xxd -p -s 0 -l 12 $targetfile`
ctime=`xxd -p -s 12 -l 8 $targetfile`
mtime=`xxd -p -s 20 -l 8 $targetfile`
dev=`xxd -p -s 28 -l 4 $targetfile`
ino=`xxd -p -s 32 -l 4 $targetfile`
mode=`xxd -p -s 36 -l 4 $targetfile`
uid=`xxd -p -s 40 -l 4 $targetfile`
gid=`xxd -p -s 44 -l 4 $targetfile`
size=`xxd -p -s 48 -l 4 $targetfile`
ohash=`xxd -p -s 52 -l 20 $targetfile`
flag=`xxd -p -s 72 -l 2 $targetfile`
path=`xxd -p -s 74 -l 10 $targetfile`
nul=`xxd -p -s 84 -l 72 $targetfile | tr -d "\n"`


echo "header : $header"
echo "ctime  : $ctime"
echo "mtime  : $mtime"
echo "dev    : $dev"
echo "ino    : $ino"
echo "uid    : $uid"
echo "gid    : $gid"
echo "size   : $size"
echo "ohash  : $ohash"
echo "flag   : $flag"
echo "path   : $path"
echo "nul    : $nul"
