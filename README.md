# GitHub Repository Cleaner

This utility provides functionalities to clean up various components of a GitHub repository including tags, action runs, releases, and all commits.

## Prerequisites

- `bash`
- `jq` (for processing JSON)
- `gh` (GitHub CLI)
- `curl`
- `git`

## Setup

1.  **Install Prerequisites**:
    - Ensure you have all the prerequisites installed.
2.  **Clone the Repository**:
    - Clone the repository to your local machine.
3.  **Navigate to the Directory**:
    - Move to the directory containing the cleanup script.
4.  **Make the Script Executable**:

    bashCopy code

    `chmod +x delete-everything.sh`

## Usage

### Basic Command:

`./delete-everything.sh <user/repo> <token> [options]`

### Required Arguments:

- `<user/repo>`: The GitHub repository in the format `username/repository_name`.
- `<token>`: Your GitHub personal access token.

### Options:

- `--deleteTags`: Delete all tags.
- `--deleteActionRuns`: Delete all GitHub Action runs.
- `--deleteReleases`: Delete all releases.
- `--deleteAllCommits`: Delete all commits.
- `--ignoreIds=id1,id2,...`: Specify action run IDs to ignore.

### Example:

To delete all tags and action runs for a specific repository:

bashCopy code

`./delete-everything.sh username/myrepo myaccesstoken --deleteTags --deleteActionRuns`

To specify certain action run IDs to ignore:

bashCopy code

`./delete-everything.sh username/myrepo myaccesstoken --ignoreIds=1234,5678`

## Warning

> :warning: Use this script with caution. The operations are irreversible. Make sure you've backed up any vital data.

## License

- Specify the licensing here or state it's open for general use.
