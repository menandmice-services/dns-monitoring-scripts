#!/bin/sh

#
# Test 18 - Checks if the authoritative nameservers provide NSEC3
# for the given zone
#

echo " == #18 - NSEC3 check == "

err=0

while read server; do
  printf "Server: ${server} "
  val=$(dig NSEC3PARAM ${1} @${server} +short +nocookie);

  if [ "${val}" != "" ]; then
    printf " NSEC3 enabled, good\n"
  else
    err=1
    printf " NSEC3 not available\n"
  fi
done <<< "$(dig NS $1 +short +nocookie)"

exit ${err}
