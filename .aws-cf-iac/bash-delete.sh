#!/bin/bash

#############################################################################
# Function: Check_Kwargs_Count
#   Checks correct number of kwargs
#
# Globals:
#   args_count=${#}
#   
# Returns:
#   0 if correct
#   1 if incorrect count
#############################################################################
Check_Kwargs_Count () {
  args_count=$1

  if [ ${args_count} -eq 1 ]
  then
    printf "Correct number of parameters\n"
  else
    printf "Incorrect number of parameters\n"
    printf "Usage: ./bash-delete.sh [STACK_NAME]\n"
    printf "Example: ./bash-delete.sh network\n"
    exit 1
  fi
}

# Script Start
Check_Kwargs_Count $#

aws cloudformation delete-stack \
--stack-name $1