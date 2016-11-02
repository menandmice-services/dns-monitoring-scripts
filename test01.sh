#!/bin/sh
# Test 1 - UDPv4 reachability - test for each authoritative server of the DNS infrastructure
dig -4 +nssearch ${1}
