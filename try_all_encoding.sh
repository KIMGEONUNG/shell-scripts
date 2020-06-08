#!/bin/bash

# Try all encoding convertion to UTF8
# Argument1 : test string file path

result_file="encoding_test_result"
encodings=$(iconv -l | sed "s/\/\///g")
test_string_file=$1

if [ -z $test_string_file ]
then
    echo "The required argument is empty."
    echo "The first arguement must be test strinf file path."
    exit 1
fi

echo "# ENCODING TEST START" > $result_file
echo "#####################" >> $result_file
echo "#####################" >> $result_file

for encoding in $encodings
do
    result=$(iconv -f $encoding -t UTF8 < $test_string_file 2> /dev/null)

    if [ $? == "0" ]
    then
        echo "ENCODING TYPE : $encoding" >> $result_file
        echo $result >> $result_file
    else
        echo "ENCODING TYPE : $encoding" >> $result_file
        echo "ENCODING FAIL!" >> $result_file
    fi
done
