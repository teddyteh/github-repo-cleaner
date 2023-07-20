# GitHub Repo Cleaner

This utility provides functionalities to clean up various components of a GitHub repository including tags, action runs, releases, and all commits.

## Prerequisites

- `bash`
- `git`
- `gh` (GitHub CLI)
- `curl`
- `jq` (for processing JSON)

## Installation

```
npm i -g github-repo-cleaner
```

## Usage

### Basic Command:

```
./delete-everything.sh <user/repo> <token> [options]
```

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

```
clean-repo username/myrepo myaccesstoken --deleteTags --deleteActionRuns
```

To specify certain action run IDs to ignore:

```
clean-repo username/myrepo myaccesstoken --ignoreIds=1234,5678
```

## Warning

> :warning: Use this script with caution. The operations are irreversible. Make sure you've backed up any vital data.

## License

- Specify the licensing here or state it's open for general use.
