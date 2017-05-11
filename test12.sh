#!/bin/sh
# Test 12 - RRSIG validity: check for the lifetime timestamps of
# RRSIGs in the zone. This test should be done for every important
# RRset in the zone (SOA, DNSKEY, MX, A/AAAA)
echo " == #12 - RRSIG validity == "

today=$(date "+%Y%m%d%H%M%S")
inception=$(dig ${1} soa +cd +dnssec | egrep "RRSIG.*SOA" | cut -d " " -f 6)
expiry=$(dig ${1} soa +cd +dnssec | egrep "RRSIG.*SOA" | cut -d " " -f 5)

echo "Today    : ${today}"
echo "Inception: ${inception}"
echo "Expiry   : ${expiry}"


if [ "${inception}" -gt "${today}" ]
then
    echo "ERROR: RRSIG validity (${inception}) is in the future"
fi

if [ "${expiry}" -lt "${today}" ]
then
    echo "ERROR: RRSIG validity (${expiry}) is in the past, DNSSEC signature has expired"
fi

twodaysahead=$(date +%s)
twodaysahead=$((${twodaysahead}+172800))
twodaysahead=$(date -u --date="@${twodaysahead}" "+%Y%m%d%H%M%S")
if [ "${expiry}" -lt "${twodaysahead}" ]
then
    echo "ERROR: RRSIG validity (${expiry}) will end in less than two days"
fi

fivedaysahead=$(date +%s)
fivedaysahead=$((${fivedaysahead}+432000))
fivedaysahead=$(date -u --date="@${fivedaysahead}" "+%Y%m%d%H%M%S")
if [ "${expiry}" -lt "${fivedaysahead}" ]
then
    echo "WARNING: RRSIG validity (${expiry}) will end in less than five days"
fi

