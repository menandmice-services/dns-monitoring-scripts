#!/bin/sh
# Test 4 - TCPv6 reachability - test for each authoritative server of the DNS infrastructure
dig -6 +nssearch +tcp ${1}
