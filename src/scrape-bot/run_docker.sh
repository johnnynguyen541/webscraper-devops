#!/usr/bin/env bash

## Variables
BOT_IP="172.18.0.3"
BOT_PORT=5002
DOCKER_NETWORK="scrape-net"
DOCKER_SUBNET="172.18.0.0/16"
TAG_BOT_ID="scrape-bot"
TAG_BOT_VERSION="1.0.2"

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