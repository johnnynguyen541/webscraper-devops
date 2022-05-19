#!/usr/bin/env bash

## Variables
BUILD_NUMBER=""
TAG_ID="scrape-api"
APP_PORT=5001

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build --tag=$TAG_ID .

# Step 2: 
# List docker images
docker image ls

# Step 3: 
# Run flask app - Print if successful
if BUILD_NUMBER=$(docker run -d -p $APP_PORT:$APP_PORT $TAG_ID)
then
    echo "Successfully built $BUILD_NUMBER"
    echo "Successfully tagged $TAG_ID"
else
    echo "Issue creating Docker image with tag id: $TAG_ID.  Please check output."
fi