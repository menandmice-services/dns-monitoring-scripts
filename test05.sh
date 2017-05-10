#!/bin/sh
# Test 5 - EDNS0 response size: tests that the server signals the
# correct EDNS0 response size. Size needs to be checked against the
# local policy. Usually 1220-1232 bytes.
echo " == #5 - EDNS0 response size == "
ednspolicy=1232
dig ns ${1} +short | while read server; do
    echo "Server: ${server} "
    ednsbuf=$(dig  @${server} ${1} | grep "; EDNS:" | cut -d " " -f 7)
    if [ "${ednsbuf}" -eq "${ednspolicy}" ]
    then
	echo " EDNS0-Bufsize is ${ednsbuf}, good "
    else
	echo " EDNS0-Bufsize is ${ednsbuf}, out of policy range "
    fi
done
