#!/bin/sh

#
# Test 14 - DS Records and KSK - test that the DS-Record matches the
# KSK in the zone. The two values (Key-ID) must match.
#

echo " == #14 - DS Records and KSK == "

if [ "$1" = "" ]; then
  echo "This test fails without domain param. Exiting..."
  exit 1
fi

err=0

dskeyid=$(dig ${1} DS +short +cd +nocookie | cut -d " " -f 1 | tail -1)
rrsigkeyid=$(dig ${1} DNSKEY +dnssec +short +cd +nocookie | egrep "^DNSKEY" | grep "${dskeyid}" | cut -d ' ' -f 7)

if [ "${dskeyid}" != "${rrsigkeyid}" ]; then
  err=1
  echo "Error: Key-Tag of DS-Records does not match the Key-Tag of RRSIG on DNSKEY"
else
  echo "OK: Key-Tag of DS-Records does match the Key-Tag of RRSIG on DNSKEY"
fi

exit ${err}
