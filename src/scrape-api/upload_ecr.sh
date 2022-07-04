#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

## Variables
AWS_ACCOUNT_ID="571863673913"
AWS_DEFAULT_REGION="us-west-2"
TAG_API_ID="scrape-api"
TAG_API_VERSION="1.0.2"

## Input Variables
ECR_TOKEN=""
IMAGE_ID=""

# Step 1:
# Docker Login
ECR_TOKEN=$(aws ecr get-login-password --region "$AWS_DEFAULT_REGION")
docker login --username AWS --password "$ECR_TOKEN" "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"

# Step 2:  
# Authenticate & tag
echo "Find Docker Image"
docker images | grep -e "$TAG_API_ID.*$TAG_API_VERSION"

# Step 3:
# Tag your image with the Amazon ECR registry, repository, and optional image tag name combination to use
echo "Tag Docker Image"
IMAGE_ID=$(docker images --filter=reference="$TAG_API_ID:$TAG_API_VERSION" --format "{{.ID}}")
docker tag "$IMAGE_ID" "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$TAG_API_ID:$TAG_API_VERSION"

# Step 4:
# Push image to a docker repository
echo "Push Docker Image"
docker push "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$TAG_API_ID:$TAG_API_VERSION"

## TO RUN ON SYSTEM
# $ sudo apt -y install awscli docker.io
# $ sudo aws configure
#     AWSAccessKeyId=AKIAYKJN3FQ444SRXJI3
#     AWSSecretKey=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

# $ ECR_TOKEN=$(aws ecr get-login-password --region "$AWS_DEFAULT_REGION")
# $ sudo docker login --username AWS --password "$ECR_TOKEN" "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com"

# $ sudo docker pull "$AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$TAG_API_ID:$TAG_API_VERSION"
# $ sudo docker run -d -p $API_PORT:$API_PORT $AWS_ACCOUNT_ID.dkr.ecr.$AWS_DEFAULT_REGION.amazonaws.com/$TAG_API_ID:$TAG_API_VERSION