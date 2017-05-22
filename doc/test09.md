# test09.sh

## Syntax

./test09.sh <DOMAIN>

## Description

The given test script verifies that the nameserver records (NS) of
the given domain point to authoritative nameservers by checking for
the "aa"-flag which indicates that a server is authoritative.

The checked nameservers are determined by querying the NS-records
of the given domain.

## Authoritative

todo

### Note on running resolving and authoritative nameservers

todo

### Note on so-called hidden masters

todo

- - -

## Further information

  * [Running An Authoritative-Only BIND Nameserver](https://ftp.isc.org/isc/pubs/tn/isc-tn-2002-2.html)
  * [Best Practices for those running Authoritative Servers](https://kb.isc.org/article/AA-00892/0/Best-Practices-for-those-running-Authoritative-Servers.html)