#!/bin/bash
while true; do
find `pwd` | grep -E ".(cpp|hpp)" | grep -v "/.git/" | entr -d sh -c "tput reset; make test;echo;date"
done
