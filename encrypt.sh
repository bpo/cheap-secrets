#!/bin/bash
#
# Encrypt a file so that everyone in `./keys/` can decrypt it.
#

if [ "$1" == "" ]; then
  echo "usage: ./encrypt.sh file"
  exit
fi

people=""
for i in `ls keys` ; do
  people="$people --encrypt-to $i"
done

rm $1.asc
gpg -a $people --encrypt-files $1

