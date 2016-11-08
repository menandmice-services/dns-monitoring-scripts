#!/bin/sh
# Test 4 - TCPv6 reachability - test for each authoritative server of
# the DNS infrastructure
dig ns ${1} +short | while read server; do
   ipaddr=$(dig ${server} aaaa +short)
   echo "Server: ${server} (${ipaddr})"
   soarec=$(dig -6  @${server} ${1} soa +cd +tcp)
   rc=$?
   if [ $rc != 0 ];
   then
       echo "Error while sending TCPv6 query to ${server}"
       exit $rc;
   else
       echo "OK"
   fi
done

