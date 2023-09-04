#!/bin/bash

if ! command -v git &> /dev/null; then
    echo "'git' is not installed or not in PATH."
    exit 1
fi

if ! command -v gh &> /dev/null; then
    echo "'gh' CLI is not installed or not in PATH."
    exit 1
fi

if ! command -v curl &> /dev/null; then
    echo "'curl' is not installed or not in PATH."
    exit 1
fi

if ! command -v jq &> /dev/null; then
    echo "'jq' is not installed or not in PATH."
    exit 1
fi

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 <user/repo> <token> [--deleteTags] [--deleteActionRuns] [--deleteReleases] [--deleteAllCommits] [--ignoreIds=id1,id2,...]"
    exit 1
fi

IFS='/' read -r USER REPO <<<"$1"
TOKEN="$2"
IGNORE_IDS=()

deleteTags=true
deleteActionRuns=true
deleteReleases=true
deleteAllCommits=false

# Process flags
for arg in "$@"; do
    case "$arg" in
    --deleteTags)
        deleteTags=true
        ;;
    --deleteActionRuns)
        deleteActionRuns=true
        ;;
    --deleteReleases)
        deleteReleases=true
        ;;
    --deleteAllCommits)
        deleteAllCommits=true
        ;;
    --ignoreIds=*)
        IFS=',' read -ra IGNORE_IDS <<<"${arg#--ignoreIds=}"
        ;;
    esac
done

SCRIPT_DIR=$(npm root -g)/github-repo-cleaner

if [ "$deleteTags" == "true" ]; then
    source "$SCRIPT_DIR/delete-all-tags.sh"
    delete_all_tags
fi

if [ "$deleteActionRuns" == "true" ]; then
    source "$SCRIPT_DIR/delete-all-action-runs.sh"
    delete_all_action_runs
fi

if [ "$deleteReleases" == "true" ]; then
    source "$SCRIPT_DIR/delete-all-releases.sh"
    delete_all_releases
fi

if [ "$deleteAllCommits" == "true" ]; then
    source "$SCRIPT_DIR/delete-all-commits.sh"
    delete_all_commits
fi

echo "Repository cleaned!"
