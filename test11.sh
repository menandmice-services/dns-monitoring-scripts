#!/bin/sh
maxsize=1232
replysize=$(dig ${1} dnskey +dnssec | grep ";; MSG SIZE" | cut -d " " -f 6)
if [ "${replysize}" -le "${maxsize}" ]
then
    echo "Good, DNSKEY RRSet size is ${replysize} which is below or equal to ${maxsize}"
else
    echo "Bad, DNSKEY RRSet size is ${replysize} which is above ${maxsize}"
fi
