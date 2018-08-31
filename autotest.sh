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

entr_command="entr -d sh -c \""
entr_command="$entr_command tput reset;"
entr_command="$entr_command echo \\\"Running tests...\\\";"
entr_command="$entr_command $PRINT_LINE;"
entr_command="$entr_command $TEST_COMMAND;"
entr_command="$entr_command echo; $PRINT_LINE;"
entr_command="$entr_command echo \\\"Running GIT Status...\\\";"
entr_command="$entr_command $PRINT_LINE;"
entr_command="$entr_command $GIT_STATUS_COMMAND;"
entr_command="$entr_command echo;"
entr_command="$entr_command date;"
entr_command="$entr_command\""

readonly FULL_COMMAND_STRING="find $PROJECT_ROOT | $grep_ignore_list $entr_command"

while true; do
  eval "$FULL_COMMAND_STRING"
done
