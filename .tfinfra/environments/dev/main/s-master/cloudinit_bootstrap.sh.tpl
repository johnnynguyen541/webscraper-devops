#!/bin/sh

# Variables
ANSIBLE_DIR="/home/ubuntu/ansible"
AWS_DIR="/home/ubuntu/.aws"
ARTIFACTS_DIR="/home/ubuntu/artifacts"
BOOTSTRAP_LOG="/var/log/cloudinit_bootstrap.log"
BOOTSTRAP_DIR="/home/ubuntu/bootstrap"
BOOTSTRAP_SCRIPT="bootstrap.sh"

main () {
  echo "Ansible Role:   ${role_tag}"
  echo "S3 Bucket Name: ${s3_bucket}"

  # Make Environment Variable: ANSIBLE_ROLE and ANSIBLE_ENV
  cat /home/ubuntu/.bashrc | grep -ie ANSIBLE_ROLE
  if [ $? -ne 0 ]
  then
    echo "Adding ANSIBLE_ROLE Environment Variable to .bashrc"
    printf "\n# ANSIBLE ENVIRONMENT VARIABLE\nANSIBLE_ROLE=${role_tag}" >> /home/ubuntu/.bashrc
    export ANSIBLE_ROLE=${role_tag}
  fi

  cat /home/ubuntu/.bashrc | grep -ie ANSIBLE_ENV
  if [ $? -ne 0 ]
  then
    echo "Adding ANSIBLE_ENV Environment Variable to .bashrc"
    printf "\nANSIBLE_ENV=${env_tag}" >> /home/ubuntu/.bashrc
    export ANSIBLE_ENV=${env_tag}
  fi

  # Install AWS CLI
  echo "Install AWS CLI"

  apt update
  apt -y install awscli

  if [ $? -ne 0 ]
  then
    echo "Failed installing awscli.  Return 1"
    return 1
  fi

  # Set AWS Credentials
  echo "Creating AWS Cli Credentials"
  mkdir $${AWS_DIR}
  echo "[default]" > $${AWS_DIR}/config
  echo "region = ${region}" >> $${AWS_DIR}/config

  chown ubuntu $${AWS_DIR}
  chgrp ubuntu $${AWS_DIR}

  # Make Ansible Dir
  echo "Creating Ansible Dir at $${ANSIBLE_DIR}"
  mkdir $${ANSIBLE_DIR}
  chown ubuntu $${ANSIBLE_DIR}
  chgrp ubuntu $${ANSIBLE_DIR}

  # Make Directories at Bootstrap and Artifacts
  echo "Make Directory at $${BOOTSTRAP_DIR}"
  mkdir $${BOOTSTRAP_DIR}

  echo "Make Directory at $${ARTIFACTS_DIR}"
  mkdir $${ARTIFACTS_DIR}

  # Copy all Bootstrap/Artifacts materials
  echo "Copying Bootstrap files to $${BOOTSTRAP_DIR}"
  aws s3 cp s3://${s3_bucket}/bootstrap/${role_tag}/ $${BOOTSTRAP_DIR}/. --recursive

  echo "Copying Artifact files to $${ARTIFACTS_DIR}"
  aws s3 cp s3://${s3_bucket}/artifacts/${role_tag}/ $${ARTIFACTS_DIR}/. --recursive

  # Make Bootstrap Script Executable and Run
  chmod u+x $${BOOTSTRAP_DIR}/$${BOOTSTRAP_SCRIPT}
  $${BOOTSTRAP_DIR}/$${BOOTSTRAP_SCRIPT} ${env_tag} ${role_tag} ${region}
}

main >> $${BOOTSTRAP_LOG}
