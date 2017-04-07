#!/bin/bash

readonly PROJECT_ROOT=$( cd "$( dirname "$0" )" && pwd )

readonly CURRENT_ULIMIT_SIZE=$(ulimit -Sn)

if [ "$CURRENT_ULIMIT_SIZE" -lt 4000 ]; then
  ulimit -Sn 5000
fi

readonly TEST_COMMAND="make -C $PROJECT_ROOT test"

while true; do
  find "$(pwd)" | grep -E ".(cpp|hpp)" | grep -v "/.git/" | entr -d sh -c "tput reset; $TEST_COMMAND;echo;date"
done
