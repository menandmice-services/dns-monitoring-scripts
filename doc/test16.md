# test16.sh

## Syntax

./test16.sh <DOMAIN>

## Description

This test validates each dns record (provided by a zone transfer)
of a domain through the primary nameserver (determined by querying
the SOA record of the domain, more precisely taking the MNAME).

To validate the dns records, delv (Domain Entity Lookup & Validation)
is used.

## Delv

todo

### Note on resolvers

For this test it is absolutely required that all your resolvers
which delv uses (this script runs on) are DNSSEC-capable.
Alternatively you may edit the sourcecode and add
@your-dnssec-capable-resolver to the delv command.

- - -

## Further information

  * [Eleven, twelve; dig and delv: BIND 9.10](https://kb.isc.org/article/AA-01152/0/Eleven-twelve-dig-and-delv%3A-BIND-9.10.html)
  * [BIND 9.10 Eintauchen in DNSSEC (german)](https://sys4.de/en/blog/2014/02/28/bind-910-eintauchen-dnssec/)