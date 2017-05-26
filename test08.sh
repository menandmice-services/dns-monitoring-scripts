#!/bin/sh

#
# test that all authoritative server for a zone have the same SOA
# serial. The return code of the dig command should be checked for
# errors.  the SOA serial can be different for short amount of times
# after an update on the master (propagation delay during zone
# transfer) on a test interval of 5 minutes the test should issue a
# warning if the same SOA difference is seen in two successive tests
# is the same SOA difference seen after three or more tests, an event
# of severity ERROR should be generated
#

echo " == #8 - SOA serial == "

oldsoaserial="0"
dig ${1} +nssearch | while read serverres; do
  soaserial=$(echo ${serverres} | cut -d ' ' -f 4)

  if [ "${oldsoaserial}" -eq "0" ]; then
    oldsoaserial=${soaserial}
  else
    if [ "${oldsoaserial}" -eq "${soaserial}" ]; then
      echo "Match for ${soaserial}"
    else
      echo "Mismatch for ${soaserial} != ${oldsoaserial}"
    fi
  fi
done
