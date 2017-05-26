#!/bin/sh

#
# simple script to call all scripts
#

err=0
failed=""

if ! type "dig" >/dev/null; then
  echo "Make sure dig is in \$PATH. Unable to find it. Exiting..."
  exit 1
fi

if ! type "delv" >/dev/null; then
  echo "Make sure delv is in \$PATH. Unable to find it. Exiting..."
  exit 1
fi

for script in test*.sh; do
  sh ./${script} ${1}
  rc=$?

  if [ ${rc} != 0 ]; then
    err=1
    failed="${failed} ${script}"
  fi
done

if [ "$err" != 0 ]; then
  echo "The following scripts failed: ${failed}..."
  exit ${err}
fi