#!/bin/bash

echo "### FINDER SCRIPT START ###"

if [ -z $1 ]
then
    echo FAIL: nO KEYWORD 
    exit 1
fi

echo KEYWORD : $1

targets=`find . -type f | grep cs$`
targetsNum=`find . -type f | grep cs$ | wc -l`

echo THE NUMBER OF TARGET FILES : $targetsNum

for target in $targets
do
    revision=`echo $target | sed "s: :\\\\\\ :g"`
    result=`cat $revision | grep $1`
    if ! [ -z $result ]
    then
        echo FILE NAME : $target
        echo $result
    fi
done

echo "### FINDER SCRIPT END ###"
