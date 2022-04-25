#!/bin/sh

#
# Test 9 - test for AA-Flag. Repeat this test for each authoritative
# server for the zone. Each server must respond with an AA-Flag
#

echo " == #9 - AA-Flag == "

err=0

while read server; do
  printf "Server: ${server} "
  aaflag=$(dig @${server} ${1} SOA +norec | grep ";; flags" | cut -d " " -f 4 | cut -b 1-2)

  if [ "${aaflag}" = "aa" ]; then
    printf " AA-Flag found, good\n"
  else
    err=1
    printf " no AA-Flag, Server not authoritative\n"
  fi
done <<< "$(dig NS $1 +short)"

exit ${err}
