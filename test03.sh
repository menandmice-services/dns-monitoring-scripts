#!/bin/sh
# Test 3 - TCPv4 reachability - test for each authoritative server of the DNS infrastructure
dig -4 +nssearch +tcp ${1}
