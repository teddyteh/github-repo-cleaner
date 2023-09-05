#!/bin/bash

function delete_all_deployments() {
    echo "Deleting all deployments..."
    while true; do
        response=$(gh api -X GET "/repos/$USER/$REPO/deployments" -H "Authorization: token $TOKEN")

        if [[ $? -ne 0 ]]; then
            echo "Error occurred while retrieving deployments."
            exit 1
        fi

        deployment_ids=$(echo "$response" | jq -r '.[]|.id')

        for deployment_id in $deployment_ids; do
            delete_response=$(gh api -X DELETE "/repos/$USER/$REPO/deployments/$deployment_id" -H "Authorization: token $TOKEN")
            if [[ $? -ne 0 ]]; then
                echo "Error occurred while deleting deployment with ID: $deployment_id"
            else
                echo "Deleted deployment with ID: $deployment_id"
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