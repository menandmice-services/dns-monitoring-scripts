#!/bin/sh

#
# Test 3 - TCPv4 reachability - test for each authoritative server of
# the DNS infrastructure
#

echo " == #3 - TCPv4 reachability == "

err=0

dig NS ${1} +short | while read server; do
  ipaddr=$(dig ${server} A +short)

  echo "Server: ${server} (${ipaddr})"
  soarec=$(dig -4 @${server} ${1} SOA +cd +tcp)
  rc=$?

  if [ ${rc} != 0 ]; then
    err=1
    echo "Error while sending TCPv4 query to ${server}"
  else
    echo "OK"
  fi
done

exit ${err}