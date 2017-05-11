#!/bin/sh
# Test 11 - test for DNSKEY RRset answer size. The full answer packet
# of the DNSKEY rrset should be below the IPv6 fragmentation payload
# limit (1232 byte)
echo " == #11 - test for DNSKEY RRset answer size == "

maxsize=1232
replysize=$(dig ${1} dnskey +dnssec +cd | grep ";; MSG SIZE" | cut -d " " -f 6)
if [ "${replysize}" -le "${maxsize}" ]
then
    echo "Good, DNSKEY RRSet size is ${replysize} which is below or equal to ${maxsize}"
else
    echo "Bad, DNSKEY RRSet size is ${replysize} which is above ${maxsize}"
fi
