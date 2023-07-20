#!/bin/bash

function delete_all_tags() {
    echo "Fetching all tags from the remote repository..."
    git fetch origin --tags -f
    if [[ $? -ne 0 ]]; then
        echo "Error occurred while fetching tags from remote."
        exit 1
    fi

    # Get only remote tags
    remote_tags=$(git ls-remote --tags origin | cut -f 2 | sed 's/refs\/tags\///')

    echo "Deleting remote tags..."
    for tag in $remote_tags; do
        git push --delete origin "$tag"
        if [[ $? -ne 0 ]]; then
            echo "Error occurred while deleting tag: $tag"
        else
            echo "Deleted remote tag: $tag"
        fi
    done
}
