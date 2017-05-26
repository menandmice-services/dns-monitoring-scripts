#!/bin/sh
# Test 18 - Checks if the authoritative nameservers provide NSEC3
# for the given zone
echo " == #18 - NSEC3 check == "

dig ns ${1} +short | while read server; do
    echo "Server: ${server} "
    val=$(dig nsec3param ${1} @${server} +short);
    if [ "${val}" != "" ]; then
	  echo " NSEC3 enabled, good "
    else
	  echo " NSEC3 not available "
    fi
done
