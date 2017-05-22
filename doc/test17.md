# test17.sh

## Syntax

./test17.sh <DOMAIN>

## Description

The given test script verifies that the checked nameservers do not
allow recursion by looking for the "ra"-flag in the output of the
dig-tool.

The checked nameservers are determined by querying the NS-records
of the given domain.

## Recursion

Recursion (sometimes also referred to as recursive requests) refers
to a nameserver which resolves queries by querying other nameservers.
As per above explanation, this is part of a resolving nameserver and
might lead to abuse (Cache-Poisoning, Reflection, DNS-Amplification
attacks).

Authoritative nameservers (NS-records point to authoritative ones)
should never perform recursion at all. Unless operating a public
resolver, recursion should only be allowed for internal
clients/systems.

## Mitigation

Disabling recursion is as simple as defining

    recursion: no;

in the options { } block. In case you are using views, you may
selectively disable and enable recursion by defining the above
in the specific view { } block instead of the options { } block.

If for any reason you do have to allow recursion for some
specific clients, you should work with acl's and allow-recursion { }.

    acl "clients" {
        192.168.0.0/24;
        localhost;
        localnets;
    }

    options {
        ...
        allow-recursion { clients; };
        ...
    }

Mind that you cannot mix recursion: no; and allow-recursion { }.

- - -

## Further information

  * [Best Practices for those running Authoritative Servers](https://kb.isc.org/article/AA-00892/0/Best-Practices-for-those-running-Authoritative-Servers.html)
  * [What has changed in the behavior of allow-recursion and allow-query-cache](https://kb.isc.org/article/AA-00269/0/What-has-changed-in-the-behavior-of-allow-recursion-and-allow-query-cache.html)