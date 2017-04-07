#!/bin/bash

readonly PROJECT_ROOT=$( cd "$( dirname "$0" )" && pwd )

while true; do
  find "$(pwd)" | grep -E ".(cpp|hpp)" | grep -v "/.git/" | entr -d sh -c "tput reset; make -C $PROJECT_ROOT test;echo;date"
done
