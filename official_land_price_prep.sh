#!/bash/bin

# data location url
# https://www.data.go.kr/data/15004246/fileData.do
# I cannot find download url 

file=$1
encoding="encodingresult.csv"
comar="comar.csv"
pnucol="pnu.csv"
paste="paste.csv"
result="result.csv"

if [ -z $file ]
then 
    echo No file specified
    exit 1
fi

if [ ! -e $file ]
then 
    echo No such file exists
    exit 1
fi


##################################
### Start Preprocessing        ###

echo OFFICAL LAND PRICE PREPROCESSOR

#Encoding cp949 --> UTF8
echo Start encoding to UTF8
iconv -f "cp949" -t UTF8 < $file > $encoding 
echo Finish 

echo Start delimiter conversion
cat $encoding | sed 's:\t:,:g' > $comar 
echo Finish 

echo Start to generate pnu column and address column
echo pnu,address > $pnucol
cat $comar | tail +2 | awk -F "\"*,\"*" '{printf "%s%s%s%04i%04i,%s%s%s\n",$2,$3,$4,$5,$6,$7,$8,$9}' >> $pnucol 
echo Finish 

echo Start to paste
paste -d ',' $pnucol $comar > $paste
echo Finish 

echo Start to filter redundant column
cat $paste | awk -F "\"*,\"*" '{printf "%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s\n",$1,$2,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24}' > $result 
echo Finish 

echo Start to remove temporary files
rm $encoding $comar $pnucol $paste
echo Finish

### Finish Preprocessing       ###
##################################


##################################
### Start To Generate Query    ###
echo Start to create query files

tablename="olp20200922"

cat<<EOF > create_table_query
create table $tablename 
(
    pnu char(19),
    address varchar(200),
    지목 varchar(10),
    면적 numeric(20,2),
    용도지역1 varchar(50),
    용도지역2 varchar(50),
    이용상황 varchar(50), 
    주위환경 varchar(50),
    지세명 varchar(50),
    형상명 varchar(50),
    도로교통 varchar(50),
    공시지가 numeric(20),
    지리적위치1 varchar(50),
    지리적위치2 varchar(50),
    방위 varchar(50)
);
EOF

cat<<EOF > import_command 
COPY $tablename FROM '/home/comar/Downloads/tmp/result.csv' WITH NULL '-' DELIMITER ',' header csv;
EOF

echo Finish

### Finish To Generate Query   ###
##################################
