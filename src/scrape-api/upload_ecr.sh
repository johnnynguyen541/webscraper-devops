#!/usr/bin/env bash
# This file tags and uploads an image to AWS ECR

## Variables Used
echo "AWS_ACCOUNT_ID = $AWS_ACCOUNT_ID"
echo "AWS_DEFAULT_REGION = $AWS_DEFAULT_REGION"
echo "TAG_API_ID = $TAG_API_ID"
echo "TAG_API_VERSION = $TAG_API_VERSION"

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
