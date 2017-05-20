# test05.sh

## Syntax

./test05.sh <DOMAIN>

## Description

This test verifies that the authoritative nameservers of the given
domain advertises a proper EDNS0 response size.

The checked nameservers are determined by querying the NS-records
of the given domain.

## EDNS0

EDNS (Extended DNS) are enhancements to the DNS protocol for the
transport of UDP DNS packets. EDNS is required for DNSSEC and
may cause trouble with older firewalls/appliances which limit DNS
UDP packets to 512 bytes. See [RFC 2671] for more information about
EDNS.

## Dealing with fragmentation

todo

## Mitigation

BIND allows to configure the EDNS(0) buffer size with the following
two values

    max-udp-size: 1232;
    edns-udp-size: 1232;

in its options { } block. The former is used in send direction, the
latter is the advertised udp-size.

- - -

## Further information

  * [DNSSEC meets real world: dealing with unreachability caused by fragmentation](http://eprints.eemcs.utwente.nl/24758/01/ieee-commag-dnssec-2014.pdf)
  * [DNSSEC: dealing with hosts that don’t get fragments](https://ripe64.ripe.net/presentations/91-20120418_-_RIPE64_-_Ljubljana_-_DNSSEC_-_UDP_issues.pdf)
  * [RFC 7872: Observations on the Dropping of Packets with IPv6 Extension Headers in the Real World](https://tools.ietf.org/html/rfc7872)

[RFC 2671]: https://tools.ietf.org/html/rfc2671