#!/bin/bash 

# Test Command
test_command() {
    cmd=$1

    echo "$(date): Testing $cmd"

    if ! command -v "$cmd" &> /dev/null
    then
        echo "$cmd command could not be found"
        exit 1
    else
        echo "$cmd command found"
    fi
}
