#!/bin/bash

readonly PROJECT_ROOT=$( cd "$( dirname "$0" )" && pwd )

readonly C_CPP_EXTENSIONS_REGEX='[.](c|cc|cp|cxx|cpp|CPP|c[+]{2}|C)$'


function main()
{
  ensure_main_file_exists "src"
  ensure_main_file_exists "tests"

  while true; do
  find "$PROJECT_ROOT" -type f |
  grep -E "$C_CPP_EXTENSIONS_REGEX" |
  entr -d bash entr_script.sh "$PROJECT_ROOT"
  done
}

function ensure_main_file_exists()
{
  local main_file=''

  while true; do
    main_file=$(find "$PROJECT_ROOT/$1" -type f | grep -E "/main$C_CPP_EXTENSIONS_REGEX")

    if [ -z "$main_file" ]
    then
      echo -e "\nERROR"
      echo "No main file found on '$1' folder!"
      echo "Please name your main file as 'main' with the appropriate extension."
      echo -e "\nRetrying in 5 seconds..."
      sleep 5
    else
      break
    fi
  done
}

main "$@"
