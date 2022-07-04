#!/usr/bin/env bash

## Variables
echo "API_IP = $API_IP"
echo "API_PORT = $API_PORT"
echo "DOCKER_NETWORK = $DOCKER_NETWORK"
echo "DOCKER_SUBNET = $DOCKER_SUBNET"
echo "TAG_API_ID = $TAG_API_ID"
echo "TAG_API_VERSION = $TAG_API_VERSION"

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