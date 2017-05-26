#!/bin/sh

#
# Test 9 - test for AA-Flag. Repeat this test for each authoritative
# server for the zone. Each server must respond with an AA-Flag
#

echo " == #9 - AA-Flag == "

dig NS ${1} +short | while read server; do
  echo "Server: ${server} "
  aaflag=$(dig @${server} ${1} SOA +norec | grep ";; flags" | cut -d " " -f 4 | cut -b 1-2)

  if [ "${aaflag}" = "aa" ]; then
    echo " AA-Flag found, good "
  else
    echo " no AA-Flag, Server not authoritative "
  fi
done
