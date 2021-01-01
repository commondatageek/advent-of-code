#!/bin/sh -

cat input.txt | sed -e $'s/(/1\\\n/g' | sed -e $'s/)/-1\\\n/g' | sort | uniq -c
