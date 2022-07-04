#!/usr/bin/env bash

## Variables
echo "BOT_IP = $BOT_IP"
echo "BOT_PORT = $BOT_PORT"
echo "DOCKER_NETWORK = $DOCKER_NETWORK"
echo "DOCKER_SUBNET = $DOCKER_SUBNET"
echo "TAG_BOT_ID = $TAG_BOT_ID"
echo "TAG_BOT_VERSION = $TAG_BOT_VERSION"

## Input Variables
BUILD_NUMBER=""

# Step 1:
# Build image and add a descriptive tag
docker build --tag="$TAG_BOT_ID:$TAG_BOT_VERSION" .

# Step 2: 
# List docker images
docker image ls

# Step 3:
# Create network
docker network create --subnet="$DOCKER_SUBNET" "$DOCKER_NETWORK"

# Step 4: 
# Run flask app - Print if successful
if BUILD_NUMBER=$(docker run --detach --publish $BOT_PORT:$BOT_PORT --net $DOCKER_NETWORK --ip $BOT_IP $TAG_BOT_ID:$TAG_BOT_VERSION)
then
    echo "Successfully built $BUILD_NUMBER"
    echo "Successfully tagged $TAG_BOT_ID:$TAG_BOT_VERSION"
else
    echo "Issue creating Docker image with tag id: $TAG_BOT_ID:$TAG_BOT_VERSION.  Please check output."
fi