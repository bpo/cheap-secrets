#!/bin/bash
#
# Decrypt a file and remove the .asc suffix.
#

if [ "$1" == "" ]; then
  echo "usage: ./decrypt.sh file"
  exit
fi

gpg $1

