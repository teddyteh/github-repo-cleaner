#!/bin/bash

function delete_all_releases() {
    echo "Deleting all releases..."
    RELEASES=$(gh api repos/$USER/$REPO/releases -H "Authorization: token $TOKEN")

    echo "$RELEASES" | jq -r '.[] | .id' | while read id; do
        gh api -X DELETE repos/$USER/$REPO/releases/$id -H "Authorization: token $TOKEN"
        if [[ $? -ne 0 ]]; then
            echo "Error occurred while deleting release with ID: $id"
        else
            echo "Deleted release with ID: $id"
        fi
    done
}
