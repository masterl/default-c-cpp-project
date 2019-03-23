#!/bin/bash

readonly PROJECT_ROOT=$( cd "$( dirname "$0" )" && pwd )
readonly PRINT_LINE='echo "=================================================="'
readonly C_CPP_EXTENSIONS_REGEX='[.](c|cc|cp|cxx|cpp|CPP|c[+]{2}|C)$'


function main() {
  ensure_main_file_exists "src"
  ensure_main_file_exists "tests"
  generate_test_command_string
  generate_entr_command_string

  while true; do
  find "$PROJECT_ROOT" -type f |
  grep -E "$C_CPP_EXTENSIONS_REGEX" |
  entr -d bash -c "$ENTR_COMMAND"
  done
}

function ensure_main_file_exists() {
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

function generate_test_command_string() {
  local command_parts=(
    'make'
    '-C'
    "$PROJECT_ROOT"
    "test"
  )

  declare -gr "TEST_COMMAND=$(array_join ' ' "${command_parts[@]}")"
}

function generate_entr_command_string() {
  local command_parts=(
    'tput reset'
    'echo "Running tests..."'
    "$PRINT_LINE"
    "$TEST_COMMAND"
    'echo'
    "$PRINT_LINE"
    'echo "Running GIT Status..."'
    "$PRINT_LINE"
    "git -C $PROJECT_ROOT status -sb"
    'echo'
    'date'
  )

  declare -gr "ENTR_COMMAND=$(array_join ';' "${command_parts[@]}")"
}

function array_join() {
  local d=$1
  shift
  echo -n "$1"
  shift
  printf "%s" "${@/#/$d}"
}

main "$@"
