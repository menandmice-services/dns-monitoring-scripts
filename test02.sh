#!/bin/sh

#
# Test 2 - UDPv6 reachability - test for each authoritative server of
# the DNS infrastructure
#

echo " == #2 - UDPv6 reachability == "

dig NS ${1} +short | while read server; do
  ipaddr=$(dig ${server} AAAA +short)

  echo "Server: ${server} (${ipaddr})"
  soarec=$(dig -6 @${server} ${1} SOA +cd)
  rc=$?

  if [ ${rc} != 0 ]; then
    echo "Error while sending UDPv6 query to ${server}"
    exit ${rc};
  else
    echo "OK"
  fi
done

