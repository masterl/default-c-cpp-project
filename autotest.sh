#!/bin/bash

readonly PROJECT_ROOT=$( cd "$( dirname "$0" )" && pwd )

ignore_list=()
ignore_list+=('/objs')
ignore_list+=('/.keep')

all_files=''

refresh_files_list()
{
  all_files=$(find "$PROJECT_ROOT" | grep -E "($PROJECT_ROOT/src)|($PROJECT_ROOT/tests)")

  for element in "${ignore_list[@]}"
  do
    all_files=$(echo "$all_files" | grep -v -E "$element")
  done
}

readonly TEST_COMMAND="make -C $PROJECT_ROOT test"

readonly GIT_STATUS_COMMAND="git -C $PROJECT_ROOT status"

readonly PRINT_LINE="echo \"==================================================\""

readonly COMMAND_STRING="tput reset;
  echo \"Running tests...\";
  $PRINT_LINE;
  $TEST_COMMAND;
  echo;
  $PRINT_LINE;
  echo \"Running GIT Status...\";
  $PRINT_LINE;
  $GIT_STATUS_COMMAND;
  echo;
  date;
"

while true; do
  refresh_files_list
  echo "${all_files[@]}" | entr -d bash -c "$COMMAND_STRING"
done
