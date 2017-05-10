#!/bin/sh
# Test 14 - DS Records and KSK - test that the DS-Record matches the
# KSK in the zone. The two values (Key-ID) must match.
echo " == #14 - DS Records and KSK == "

dskeyid=$(dig ${1} ds +short +cd | cut -d " " -f 1 | tail -1)
rrsigkeyid=$(dig ${1} dnskey +dnssec +short +cd | egrep "^DNSKEY" | grep "${dskeyid}" | cut -d ' ' -f 7)

if [ "${dskeyid}" != "${rrsigkeyid}" ]
then
    echo "Error: Key-Tag of DS-Records does not match the Key-Tag of RRSIG on DNSKEY"
else
    echo "OK: Key-Tag of DS-Records does match the Key-Tag of RRSIG on DNSKEY"
fi
  
