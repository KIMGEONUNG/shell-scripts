#!/bin/bash

thisFile=$0
files=`find . -type f | grep -v $thisFile | grep -v \\.git/ | grep -v swp$`
readme=pseudo.md

echo \# Shell Script Stoarge > $readme
echo  >> $readme 
echo This is personal shell script storage for reuse >> $readme 
echo  >> $readme 
echo \#\# Script Specification >> $readme
echo  >> $readme 
echo \| Script \| Usage \| >> $readme
echo \|:------:\|:-----:\| >> $readme

for filePath in $files
do
    #echo $file
    firstLine=`cat $filePath | head -1`
    #echo $firstLine
    if [ "$firstLine" == "#!/bin/bash" ]
    then
        #echo this is shell script
        contents="None"
        echo \|$filePath\|$contents\| >> $readme
    fi
done

