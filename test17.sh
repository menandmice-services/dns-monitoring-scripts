#!/bin/sh

#
# Test 17 - Checks if the authoritative nameservers have recursion
# enabled by looking for the ra-flag in dig. According to the BIND
# best practices recursion should be disabled for authoritative
# nameservers
#

echo " == #17 - Recursion check == "

err=0

dig NS ${1} +short | while read server; do
  printf "Server: ${server} "

  if dig ${1} SOA @${server} | awk '/;; flags:/' | grep -q " ra"; then
    err=1
    printf " Recursion enabled, bad if this is an authoritative server\n"
  else
    printf " Recursion disabled, good\n"
  fi
done

exit ${err}
