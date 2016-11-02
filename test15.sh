#!/bin/sh
# Test 15 Count of DNSKEY records in the zone. The number can change
# during a key-rollover. Any change should create an WARNING event

olddnskeycount=$(cat $0.saved.dnskeycount)

dnskeycount=$(dig ${1} dnskey +dnssec | egrep "DNSKEY.*2" | grep -v "RRSIG" | wc -l)
echo "${dnskeycount}" > $0.saved.dnskeycount

if [ "${dnskeycount}" != "${olddnskeycount}" ]
then
    echo "Warning: Number of DNSKEY-Record has changed!"
fi

