#!/bin/sh
# Test 16 validates all records of a given domain using delv.

# Enter the IP of your authoritative nameserver
# zone transfers needs to be allowed for the system
# you're starting this script from
AUTHORITATIVE=""

unsigned=0
errornous=0
validated=0

while read -r domain rr; do
    # mind that this will use your local resolver; so you
    # need to make sure there are only dnssec-capable
    # resolvers in your /etc/resolv.conf. Alternatively
    # add @resolver-ip-address-or-hostname to the below cmd
    out=$(delv +cdflag +nodnssec +nottl +noclass ${domain} ${rr});
    state=$(echo "${out}" | head -n1);
    if [[ "${state}" == "; unsigned answer" ]]; then
      echo -n "Unsigned record: ";
      ((unsigned=$unsigned+1))
    elif [[ "${state}" != "; fully validated" ]]; then
      echo -n "Errornous record: ";
      ((errornous=$errornous+1))
    else
      echo -n "Validated record: ";
      ((validated=$validated+1))
    fi
    echo "$domain ($rr)";
done< <(dig -t axfr -q ${1} @${AUTHORITATIVE} | grep -v "NSEC\|RRSIG\|DNSKEY\|^;\|^$" | awk '{ print $1,$4 }' | sort -u)

echo "validated/unsigned/errors: $validated/$unsigned/$errornous";