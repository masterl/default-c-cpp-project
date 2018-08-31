#!/bin/bash

readonly PROJECT_ROOT=$( cd "$( dirname "$0" )" && pwd )

ignore_list=()
ignore_list+=('/[.]git')
ignore_list+=('/autotest.sh') # You should manually restart this script upon editing it
ignore_list+=('/[.]gitignore')
ignore_list+=('/objs')
ignore_list+=('/bin')

prefixed_ignore_list=()

prefix_ignore_list()
{
  for element in "${ignore_list[@]}"
  do
    prefixed_ignore_list+=("$PROJECT_ROOT$element")
  done
}

prefix_ignore_list

grep_ignore_list=''

for element in "${prefixed_ignore_list[@]}"
do
  grep_ignore_list="$grep_ignore_list grep -v \"$element\" |"
done


readonly TEST_COMMAND="make -C $PROJECT_ROOT test"

readonly GIT_STATUS_COMMAND="git status"
readonly PRINT_LINE="echo \\\"==================================================\\\""

readonly FULL_COMMAND_STRING="find $PROJECT_ROOT |
grep -E \"($PROJECT_ROOT/src)|($PROJECT_ROOT/tests)\" |
${grep_ignore_list}
entr -d bash -c \"
  tput reset;
  echo \\\"Running tests...\\\";
  $PRINT_LINE;
  $TEST_COMMAND;
  echo;
  $PRINT_LINE;
  echo \\\"Running GIT Status...\\\";
  $PRINT_LINE;
  $GIT_STATUS_COMMAND;
  echo;
  date;
  \"
"

while true; do
  eval "$FULL_COMMAND_STRING"
done
