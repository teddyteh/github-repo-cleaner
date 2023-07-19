#!/bin/bash

function delete_all_action_runs() {
    echo "Deleting all action runs..."
    while true; do
        response=$(gh api -X GET "/repos/$USER/$REPO/actions/runs" -H "Authorization: token $TOKEN")

        if [[ $? -ne 0 ]]; then
            echo "Error occurred while retrieving actions runs."
            exit 1
        fi

        run_ids=$(echo "$response" | jq -r '.workflow_runs[].id')

        for run_id in $run_ids; do
            ignore=false
            for ignore_id in "${IGNORE_IDS[@]}"; do
                if [[ "$run_id" == "$ignore_id" ]]; then
                    ignore=true
                    break
                fi
            done

            if [[ "$ignore" == true ]]; then
                continue
            fi

            delete_response=$(gh api -X DELETE "/repos/$USER/$REPO/actions/runs/$run_id" -H "Authorization: token $TOKEN")
            if [[ $? -ne 0 ]]; then
                echo "Error occurred while deleting run with ID: $run_id"
            else
                echo "Deleted run with ID: $run_id"
            fi
        done

        next_link=$(echo "$response" | grep -i "rel=\"next\"" | sed -n 's/.*<\(.*\)>.*/\1/p')
        if [[ -n "$next_link" ]]; then
            url="$next_link"
        else
            break
        fi
    done
}