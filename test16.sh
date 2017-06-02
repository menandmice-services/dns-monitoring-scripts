#!/bin/sh

#
# Test 16 validates all records of a given domain using delv.
#

echo " == #16 - Delv zone validation == "

# Enter the IP of your authoritative nameserver
# zone transfers needs to be allowed for the system
# you're starting this script from
AUTHORITATIVE=""

if [ "$AUTHORITATIVE" = "" ]; then
  AUTHORITATIVE=$(dig +short ${1} SOA | cut -d' ' -f1)
fi

ZONEDATA=$(dig -t axfr -q ${1} @${AUTHORITATIVE})

if echo "${ZONEDATA}" | grep -q "Transfer failed"; then
  echo "Zone transfers disabled; Exiting..."
  exit 1
fi

err=0
unsigned=0
errornous=0
validated=0

(echo "${ZONEDATA}" | grep -v "NSEC\|RRSIG\|DNSKEY\|^;\|^$" | awk '{ print $1,$4 }' | sort -u) |
{ while read -r domain rr; do
    # mind that this will use your local resolver; so you
    # need to make sure there are only dnssec-capable
    # resolvers in your /etc/resolv.conf. Alternatively
    # add @resolver-ip-address-or-hostname to the below cmd
    out=$(delv +cdflag +nodnssec +nottl +noclass ${domain} ${rr});
    state=$(echo "${out}" | head -n1);
    if [ "${state}" = "; unsigned answer" ]; then
      printf "Unsigned record: ";
      unsigned=$((unsigned+1))
    elif [ "${state}" != "; fully validated" ]; then
      err=1
      printf "Errornous record: ";
      errornous=$((errornous+1))
    else
      printf "Validated record: ";
      validated=$((validated+1))
    fi
    echo "$domain ($rr)";
  done

  echo "validated/unsigned/errors: $validated/$unsigned/$errornous";
}

exit ${err}