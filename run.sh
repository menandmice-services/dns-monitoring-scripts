#!/bin/sh

#
# simple script to call all scripts
#

if ! type "dig" >/dev/null; then
  echo "Make sure dig is in \$PATH. Unable to find it. Exiting..."
  exit 1
fi

if ! type "delv" >/dev/null; then
  echo "Make sure delv is in \$PATH. Unable to find it. Exiting..."
  exit 1
fi

for script in test*.sh; do
  ./${script} ${1}
done
