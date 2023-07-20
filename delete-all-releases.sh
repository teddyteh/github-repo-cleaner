#!/bin/bash

function delete_all_releases() {
    echo "Deleting all releases..."
    RELEASES=$(gh api repos/$USER/$REPO/releases -H "Authorization: token $TOKEN")

    echo "$RELEASES" | jq -r '.[] | .id' | while read id; do
        curl --silent --show-error --header "Authorization: token $TOKEN" --request DELETE "https://api.github.com/repos/$USER/$REPO/releases/$id"
    done
}