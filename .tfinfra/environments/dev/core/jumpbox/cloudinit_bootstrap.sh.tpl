#!/bin/sh

# Variables
# Main
USER=$(WHOAMI)

# ENV VARS
AWS_DIR="/home/$USER/.aws"
ARTIFACTS_DIR="/home/$USER/artifacts"
BOOTSTRAP_LOG="/var/log/cloudinit_bootstrap.log"
BOOTSTRAP_DIR="/home/$USER/bootstrap"
BOOTSTRAP_SCRIPT="bootstrap.sh"

main () {
  echo "Environment Tag: ${s3_bucket}"
  echo "Region:          ${region}"
  echo "Instance Role:   ${role_tag}"
  echo "S3 Bucket Name:  ${s3_bucket}"

  # Install AWS CLI
  echo "Install AWS CLI"

  apt update
  apt -y install awscli

  if [ $? -ne 0 ]
  then
    echo "Failed installing awscli.  Return 1"
    return 1
  fi
}

main >> $${BOOTSTRAP_LOG}
