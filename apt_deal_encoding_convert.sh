#!/bash/bin

ENCODING_POSTFIX=_utf8.csv
CATTEN_FILE=result_tmp
RESULT_FILE=result.csv

rm $RESULT_FILE 2> /dev/null

# Encoding conversion
for file in *.csv
do
    echo file name is $file
    PREFIX=$(echo $file | sed -E s/^\(.+\)\.csv/\\1/)
    iconv -f cp949 -t UTF8 -o ${PREFIX}${ENCODING_POSTFIX} < $file
done

tail *$ENCODING_POSTFIX -n+17 > $CATTEN_FILE

rm *${ENCODING_POSTFIX}
cat $CATTEN_FILE | sed "s/\",\"/|/g" | sed "s/\"//g" | sed "s/,//g" | grep -v "^$" | grep -v "=="> $RESULT_FILE

rm *${CATTEN_FILE}
