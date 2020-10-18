#!/bin/bash
#`cat .git/logs/HEAD | grep commit | sed 's:.\+commit\:\ ::' | sed 's:.\+(amend)\:\ ::' | sed 's:.\+(initial)\:\ ::'`
cntTotal=`cat .git/logs/HEAD | grep commit | wc -l`
cntMatch=`cat .git/logs/HEAD | grep commit | sed 's:.\+commit\:\ ::' | sed 's:.\+(amend)\:\ ::' | sed 's:.\+(initial)\:\ ::' | sed 's:^\(feat\|add\|docs\|refact\)\:\ .\+$:match:' | grep ^match | wc -l`

percent=`awk -v var1=$cntMatch -v var2=$cntTotal 'BEGIN { print  ( var1 / var2 ) * 100}'`

echo total count : $cntTotal
echo match count : $cntMatch
echo percentage \ : $percent
