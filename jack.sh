#!/bin/bash

# read parameters: 1st git url, 2nd local directory
GIT_URL="$1"
DIR_NAME="$2"

# two parameters
if [ -z "$GIT_URL" ] || [ -z "$DIR_NAME" ]; then
    echo "Please check the format.
          Usage: "./hw1.sh git_url folder_path""
    exit 1 
fi

# check for clone
if [ ! -d "$DIR_NAME" ]; then
    if git clone "$GIT_URL" "$DIR_NAME"; then
        echo "Success: Pulled from $GIT_URL to $DIR_NAME"
        ls -l $DIR_NAME
        exit 0
    else
        echo "Failed to clone from $GIT_URL to $DIR_NAME"
        exit 1
    fi
# check for pull
else 
    cd $DIR_NAME

    if git pull; then
        echo "Success: Pulled from $GIT_URL to $DIR_NAME"
        ls -l 
        exit 0
    else
        echo "Failed to clone from $GIT_URL to $DIR_NAME"
        exit 1
    fi
fi
