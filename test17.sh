#!/bin/sh
# Test 17 - Checks if the authoritative nameservers have recursion
# enabled by looking for the ra-flag in dig. According to the BIND
# best practices recursion should be disabled for authoritative
# nameservers
echo " == #17 - Recursion check == "

dig ns ${1} +short | while read server; do
    echo "Server: ${server} "
    if dig ${1} SOA @${server} | awk '/;; flags:/' | grep -q " ra"; then
	  echo " Recursion enabled, bad if this is an authoritative server "
    else
	  echo " Recursion disabled, good "
    fi
done
