#!/bin/sh

#
# Test 19 - Checks if a secure algorithm is used
# for the given zone
#

echo " == #19 - DNSSEC algorithm check == "

algorithm=$(dig DS ${1} +short | awk '{print $2}');
case ${algorithm} in
  1)
    out=" Bad, deprecated algorithm RSA/MD5 in use "
    ;;
  3)
    out=" Bad, insecure algorithm DSA/SHA1 in use "
    ;;
  5)
    out=" Bad, insecure algorithm RSA/SHA-1 in use "
    ;;
  6)
    out=" Bad, insecure algorithm DSA-NSEC3-SHA1 in use "
    ;;
  7)
    out=" Bad, insecure algorithm RSASHA1-NSEC3-SHA1 in use "
    ;;
  8)
    out=" Good, secure algorithm RSA/SHA256 in use "
    ;;
  10)
    out=" Good, secure algorithm RSA/SHA512 in use "
    ;;
  12)
    out=" Bad, insecure algorithm GOST R 34. 10-2001 (ECC-GHOST) in use "
    ;;
  13)
    out=" Good, secure algorithm ECDSA Curve P-256 with SHA-256 (ECDSAP256SHA256) in use "
    ;;
  14)
    out=" Good, secure algorithm ECDSA Curve P-384 with SHA-384 (ECDSAP384SHA384) in use "
    ;;
  15)
    out=" Good, secure algorithm Ed25519 in use "
    ;;
  16)
    out=" Good, secure algorithm Ed448 in use "
    ;;
  *)
    out=" Not implemented, yet or Reserved "
    exit 1
    ;;
esac
echo -n "${out}"
