#!/bin/bash

thisFile=$0
files=`find . -type f | grep -v \\.git/ | grep -v swp$`
readme=README.md

echo \# Shell Script Stoarge > $readme
echo  >> $readme 
echo This is personal shell script storage for reuse >> $readme 
echo  >> $readme 
echo \#\# Script Specification >> $readme
echo  >> $readme 
echo \| Script \| Usage \| >> $readme
echo \|:-------\|:------\| >> $readme

for filePath in $files
do
    #echo $file
    firstLine=`cat $filePath | head -1`
    #echo $firstLine
    if [ "$firstLine" == "#!/bin/bash" ]
    then
        echo SCRIPT FILE DETECTED: $filePath 
        contents=`cat $filePath | grep "^# SUMMARY" | head -1 | sed "s:# SUMMARY\: \(.\+\):\1:"`
        if [ -z "$contents" ]
        then
            contents="-"
        fi

        echo \|$filePath\|$contents\| >> $readme
    fi
done

