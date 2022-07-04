#!/usr/bin/env bash

## Variables
API_IP="172.18.0.2"
API_PORT=5001
DOCKER_NETWORK="scrape-net"
DOCKER_SUBNET="172.18.0.0/16"
TAG_API_ID="scrape-api"
TAG_API_VERSION="1.0.2"

## Input Variables
BUILD_NUMBER=""

# Step 1:
# Build image and add a descriptive tag
docker build --tag="$TAG_API_ID:$TAG_API_VERSION" .

# Step 2: 
# List docker images
docker image ls

# Step 3:
# Create network
docker network create --subnet="$DOCKER_SUBNET" "$DOCKER_NETWORK"

# Step 4: 
# Run flask app - Print if successful
if BUILD_NUMBER=$(docker run --detach --publish $API_PORT:$API_PORT --net $DOCKER_NETWORK --ip $API_IP $TAG_API_ID:$TAG_API_VERSION)
then
    echo "Successfully built $BUILD_NUMBER"
    echo "Successfully tagged $TAG_API_ID:$TAG_API_VERSION"
else
    echo "Issue creating Docker image with tag id: $TAG_API_ID:$TAG_API_VERSION.  Please check output."
fi