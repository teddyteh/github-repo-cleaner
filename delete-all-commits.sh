#!/bin/bash

function delete_all_commits() {
    echo "Deleting all commits..."

    # Checkout
    git checkout --orphan latest_branch
    if [[ $? -ne 0 ]]; then
        echo "Error occurred while checking out to new branch."
        exit 1
    fi

    # Add all files
    git add -A
    if [[ $? -ne 0 ]]; then
        echo "Error occurred while adding files."
        exit 1
    fi

    # Commit the changes
    git commit -am "chore: initial commit"
    if [[ $? -ne 0 ]]; then
        echo "Error occurred while committing."
        exit 1
    fi

    # Delete the 'main' branch
    git branch -D main
    if [[ $? -ne 0 ]]; then
        echo "Error occurred while deleting the main branch."
        exit 1
    fi

    # Rename the current branch to 'main'
    git branch -m main
    if [[ $? -ne 0 ]]; then
        echo "Error occurred while renaming the branch."
        exit 1
    fi

    # Force update the repository
    git push -f origin main
    if [[ $? -ne 0 ]]; then
        echo "Error occurred while pushing to origin."
        exit 1
    fi
}
