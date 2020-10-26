#!/bin/bash

echo "### FINDER SCRIPT START ###"

if [ -z $1 ]
then
    echo FAIL: NO KEYWORD
    exit 1
fi

echo KEYWORD : $1

targetsNum=`find . -type f | grep cs$ | wc -l`
targets=`find . -type f | grep cs$ | sed "s: :\\\ :g"`
targetflatten=`find . -type f | grep cs$`
targetrevision=`echo $targetflatten | sed "s: ./:;./:g"`

echo THE NUMBER OF TARGET FILES : $targetsNum

IFS=";"

for target in $targetrevision
do
    result=`cat $target | grep $1 -n`
    if ! [ -z $result ]
    then
        echo FILE NAME : $target
        echo $result
    fi
done

echo "### FINDER SCRIPT END ###"
