#!/bin/sh
# Test 2 - UDPv6 reachability - test for each authoritative server of the DNS infrastructure
dig -6 +nssearch ${1}
