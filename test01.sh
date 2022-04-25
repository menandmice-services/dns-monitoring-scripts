#!/bin/sh

#
# Test 1 - UDPv4 reachability - test for each authoritative server of
# the DNS infrastructure
#

echo " == #1 - UDPv4 reachability == "

err=0

while read server; do
  ipaddr=$(dig ${server} A +short)

  echo "Server: ${server} (${ipaddr})"
  soarec=$(dig -4 @${server} ${1} SOA +cd)
  rc=$?

  if [ ${rc} != 0 ]; then
    err=1
    echo "Error while sending UDPv4 query to ${server}"
  else
    echo "OK"
  fi
done <<< "$(dig NS $1 +short +nocookie)"

exit ${err}
