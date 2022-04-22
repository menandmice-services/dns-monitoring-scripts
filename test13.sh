#!/bin/sh

#
# Test 13 - DS Records - test the number and the content of the DS
# records in the parent zone. Issue a warning when the count or the
# content changes
#

echo " == #13 - DS Records == "

err=0

if [ -f "$0.$1.saved.dscontent" ]; then
  oldds=$(cat $0.$1.saved.dscontent)
  olddscount=$(cat $0.$1.saved.dscount)
else
  echo "First run. This result won't be meaningful until the next run.";
fi

ds=$(dig ${1} DS +short +nocookie)
echo "${ds}" > $0.$1.saved.dscontent

dscount=$(dig ${1} DS +short +nocookie | wc -l)
echo "${dscount}" > $0.$1.saved.dscount

if [ "${ds}" != "${oldds}" ]; then
  err=1
  echo "Warning: DS-Record has changed!"
else
  echo "OK: DS-Record is the same as last time tested."
fi

if [ "${dscount}" != "${olddscount}" ]; then
  err=1
  echo "Warning: number of DS-Records has changed!"
else
  echo "OK: number of DS-Records is the same as last time tested."
fi

exit ${err}
