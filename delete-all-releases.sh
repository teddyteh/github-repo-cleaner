#!/bin/bash

# Update these
USER=user
REPO=repo
TOKEN=token

# List all releases
RELEASES=$(gh api repos/$USER/$REPO/releases)

# For each release
echo "$RELEASES" | jq -r '.[] | .id' | while read id; do
    # Delete the release
    curl --silent --show-error --header "Authorization: token $TOKEN" --request DELETE "https://api.github.com/repos/$USER/$REPO/releases/$id"
done
