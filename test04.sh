#!/bin/sh

#
# Test 4 - TCPv6 reachability - test for each authoritative server of
# the DNS infrastructure
#

echo " == #4 - TCPv6 reachability == "

err=0

dig NS ${1} +short | while read server; do
  ipaddr=$(dig ${server} AAAA +short)

  echo "Server: ${server} (${ipaddr})"
  soarec=$(dig -6 @${server} ${1} SOA +cd +tcp)
  rc=$?

  if [ ${rc} != 0 ]; then
    err=1
    echo "Error while sending TCPv6 query to ${server}"
  else
    echo "OK"
  fi
done

exit ${err}