#!/bin/sh
# Test 13 - DS Records - test the number and the content of the DS
# records in the parent zone. Issue a warning when the count or the
# content changes

oldds=$(cat $0.saved.dscontent)
olddscount=$(cat $0.saved.dscount)

ds=$(dig ${1} ds +short)
echo "${ds}" > $0.saved.dscontent

dscount=$(dig ${1} ds +short | wc -l)
echo "${dscount}" > $0.saved.dscount

if [ "${ds}" != "${oldds}" ]
then
    echo "Warning: DS-Record has changed!"
fi

if [ "${dscount}" != "${olddscount}" ]
then
    echo "Warning: number of DS-Record has changed!"
fi
