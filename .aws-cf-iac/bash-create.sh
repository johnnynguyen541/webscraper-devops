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

  if [ ${args_count} -eq 3 ]
  then
    printf "Correct number of parameters\n"
  else
    printf "Incorrect number of parameters\n"
    printf "Usage: ./bash-create.sh [STACK_NAME] [TEMPLATE_FILE] [CIRCLECI_ID]\n"
    printf "Example: ./bash-create.sh network aws-network.yml default\n"
    exit 1
  fi
}

# Script Start
Check_Kwargs_Count $#

aws cloudformation deploy \
--stack-name $1 \
--template-file $2 \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--parameter-overrides ID=$3 