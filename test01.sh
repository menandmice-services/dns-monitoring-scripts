#!/bin/sh

#
# Test 1 - UDPv4 reachability - test for each authoritative server of
# the DNS infrastructure
#

echo " == #1 - UDPv4 reachability == "

dig NS ${1} +short | while read server; do
  ipaddr=$(dig ${server} A +short)

  echo "Server: ${server} (${ipaddr})"
  soarec=$(dig -4 @${server} ${1} SOA +cd)
  rc=$?

  if [ ${rc} != 0 ]; then
    echo "Error while sending UDPv4 query to ${server}"
    exit ${rc};
  else
    echo "OK"
  fi
done
