#!/bin/bash

readonly PROJECT_ROOT=$( cd "$( dirname "$0" )" && pwd )

function main() {
  ensure_main_file_exists
  echo 'end'
}

function ensure_main_file_exists() {
  local main_file=''

  while true; do
    main_file=$(find "$PROJECT_ROOT/src" -type f | grep -E "/main[.](c|cc|cp|cxx|cpp|CPP|c[+]{2}|C)$")

    if [ -z "$main_file" ]
    then
      echo -e "\nERROR"
      echo "No main file found on 'src' folder!"
      echo "Please name your main file as 'main' with the appropriate extension."
      echo -e "\nRetrying in 5 seconds..."
      sleep 5
      continue
    else
      break
    fi

    # echo "$main_file"
    # sleep 2
  done

  # while true; do
  #   if [ ! -f "$EXPECTED_OUTPUT_FILE" ]; then
  #     tput reset
  #     echo -e "Expected output file wasn't found!\\n"
  #     echo "Missing file:"
  #     echo "    $EXPECTED_OUTPUT_FILE"
  #     echo "$DIV_LINE"
  #     date
  #     sleep 2
  #     continue
  #   fi
  # done
}

# ignore_list=()
# ignore_list+=('/objs')
# ignore_list+=('/.keep')
#
# all_files=''
#
# refresh_files_list()
# {
#   all_files=$(find "$PROJECT_ROOT" | grep -E "($PROJECT_ROOT/src)|($PROJECT_ROOT/tests)")
#
#   for element in "${ignore_list[@]}"
#   do
#     all_files=$(echo "$all_files" | grep -v -E "$element")
#   done
# }
#
# readonly TEST_COMMAND="make -C $PROJECT_ROOT test"
#
# readonly GIT_STATUS_COMMAND="git -C $PROJECT_ROOT status"
#
# readonly PRINT_LINE="echo \"==================================================\""
#
# readonly COMMAND_STRING="tput reset;
#   echo \"Running tests...\";
#   $PRINT_LINE;
#   $TEST_COMMAND;
#   echo;
#   $PRINT_LINE;
#   echo \"Running GIT Status...\";
#   $PRINT_LINE;
#   $GIT_STATUS_COMMAND;
#   echo;
#   date;
# "

# while true; do
#   refresh_files_list
#   echo "${all_files[@]}" | entr -d bash -c "$COMMAND_STRING"
# done

main "$@"
