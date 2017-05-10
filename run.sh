#!/bin/sh

#
# simple script to call all scripts
#

for script in test*.sh; do
  ./${script} ${1}
done