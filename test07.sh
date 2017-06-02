#!/bin/sh

#
# Test 7 - test that all authoritative server for a zone respond on
# TCP/IPv4. Count is tested against the number of delegation
# authoritative servers for the zone.
#

echo " == #7 - IPv4 (TCP) zone response tests == "

err=0
# get TLD for the zone
tld=$(echo ${1} | rev | cut -d'.' -f 1 | rev)
# pick one TLD auth server
tldns=$(dig NS ${1}. +short | tail -1)
# query and count the delegation NS records for the zone
parentnsnum=$(dig @${tldns} NS ${1} +short | wc -l)
# query the authoritative DNS servers for the zone
childnsnum=$(dig -4 ${1} +nssearch +tcp | wc -l)

if [ "${parentnsnum}" -eq "${childnsnum}" ]; then
  echo "all authoritative DNS-Server answer"
else
  err=1
  echo "Error: Mismatch"
  echo "Auth DNS-Servers in Delegation: ${parentnsnum}"
  echo "Auth DNS-Servers in answering: ${childnsnum}"
fi

exit ${err}