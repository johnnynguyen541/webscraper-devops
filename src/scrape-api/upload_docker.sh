#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub

# Assumes that an image is built via `run_docker.sh`

## Variables
DOCKER_ID="johnnynguyen541"
TAG_ID="scrape-api"
IMAGE_VERSION="v1.0.0"

# Step 1:
# Create dockerpath
# dockerpath=<your docker ID/path>
export DOCKERPATH="$DOCKER_ID/$TAG_ID:$IMAGE_VERSION"

# Step 2:  
# Authenticate & tag
echo "Docker ID and Image: $DOCKERPATH"
docker login --username $DOCKER_ID --password "$DOCKER_PASSWORD"
docker tag $TAG_ID $DOCKERPATH

# Step 3:
# Push image to a docker repository
docker push $DOCKERPATH
