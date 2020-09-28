# data location url
# https://www.data.go.kr/data/15004246/fileData.do
# I cannot find download url 

file=$1
encoding="encodingresult.csv"
comar="comar.csv"
pnucol="pnu.csv"
result="result.csv"

echo OFFICAL LAND PRICE PREPROCESSOR

#Encoding cp949 --> UTF8
echo Start encoding to UTF8
iconv -f "cp949" -t UTF8 < $file > $encoding 
echo Finish 

echo Start delimiter conversion
cat $encoding | sed 's:\t:,:g' > $comar 
echo Finish 

echo Start to generate pnu column
echo pnu > $pnucol
cat $comar | tail +2 | awk -F "\"*,\"*" '{printf "%s%s%s%04i%04i\n",$2,$3,$4,$5,$6}' >> $pnucol 
echo Finish 

echo Start to paste
paste -d ',' $pnucol $comar > $result
echo Finish 

#Create PNU
