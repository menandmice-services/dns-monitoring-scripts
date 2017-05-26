#!/bin/sh

#
# Test 10 - test for Parent-Child NS-RRset. Tests that the NS-RRset in
# the parent zone (delegation) matches the NS-RRset in the zone data.
#

echo " == #10 - test for Parent-Child NS-RRset == "

if [ "$1" = "" ]; then
  echo "This test fails without param. Exiting..."
  exit 1
fi

err=0
# get one authoritative server for the zone
child_dns=$(dig NS ${1} +short | tail -1)
# get TLD of Domain
tld=$(echo ${1} | rev | cut -d'.' -f 1 | rev)
# get one authoritative server for the TLD
tldns=$(dig NS ${tld}. +short | tail -1)
# query the delegation records
parns=$(dig @${tldns} NS ${1} +norec +noall +authority | grep "IN.*NS" | sort)

while read nsrec; do
  ns=$(echo ${nsrec} | cut -d ' ' -f 5)
  parentns="${parentns} ${ns}"
done <<EOF
${parns}
EOF

# query the zone records
childns=$(dig @${child_dns} NS ${1} +short +norec | sort)
parentns=$(echo ${parentns} | tr ' ' '\n' | sort)

echo "Parent delegation:"
echo ${parentns}
echo "Child zonedata:"
echo ${childns}

if [ "${childns}" = "${parentns}" ]; then
  echo "Parent/Child NS-RRSet matches"
else
  err=1
  echo "Parent/Child NS-RRSet mismatch"
fi

exit ${err}