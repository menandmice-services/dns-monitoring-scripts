#!/bin/sh

#
# Test 15 Count of DNSKEY records in the zone. The number can change
# during a key-rollover. Any change should create an WARNING event
#

echo " == #15 - DNSKEY record count == "

if [ -f "$0.$1.saved.dnskeycount" ]; then
  olddnskeycount=$(cat $0.$1.saved.dnskeycount)
else
  echo "First run. This result won't be meaningful until the next run.";
fi

err=0
dnskeycount=$(dig ${1} DNSKEY +cd +dnssec +nocookie | egrep "DNSKEY.*2" | grep -v "RRSIG" | wc -l)

echo "${dnskeycount}" > $0.$1.saved.dnskeycount

if [ "${dnskeycount}" != "${olddnskeycount}" ]; then
  err=1
  echo "Warning: Number of DNSKEY-Records has changed!"
else
  echo "OK: Number of DNSKEY-Records is the same as with last test."
fi

exit ${err}
