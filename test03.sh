#!/bin/sh

#
# Test 3 - TCPv4 reachability - test for each authoritative server of
# the DNS infrastructure
#

echo " == #3 - TCPv4 reachability == "

dig NS ${1} +short | while read server; do
  ipaddr=$(dig ${server} a +short)

  echo "Server: ${server} (${ipaddr})"
  soarec=$(dig -4  @${server} ${1} soa +cd +tcp)
  rc=$?

  if [ ${rc} != 0 ]; then
    echo "Error while sending TCPv4 query to ${server}"
    exit ${rc};
  else
    echo "OK"
  fi
done
