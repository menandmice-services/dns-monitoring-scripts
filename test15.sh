#!/bin/sh
# Test 15 Count of DNSKEY records in the zone. The number can change
# during a key-rollover. Any change should create an WARNING event

olddnskeycount=$(cat $0.$1.saved.dnskeycount)

dnskeycount=$(dig ${1} dnskey +cd +dnssec | egrep "DNSKEY.*2" | grep -v "RRSIG" | wc -l)
echo "${dnskeycount}" > $0.$1.saved.dnskeycount

if [ "${dnskeycount}" != "${olddnskeycount}" ]
then
    echo "Warning: Number of DNSKEY-Record has changed!"
else
    echo "OK: Number of DNSKEY-Record is the same as with last test!"
fi

