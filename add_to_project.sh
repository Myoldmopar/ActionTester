#!/bin/bash

# call with the PR number as a command line argument
# the PROJ_ID environment variable should be set from an ACTION SECRET

CONTENT=`gh pr view $1 --json 'id' --jq '.id'`
echo "Found PR node ID as: ${CONTENT}"
echo "Using Project ID as: ${PROJ_ID}"
#
# Need to get Node ID for the issue or PR to add if we do it this way
gh api graphql -f query="
  mutation {
    addProjectV2ItemById(input: {projectId: ${PROJ_ID} contentId: ${CONTENT}}) {
      item {
        id
      }
    }
  }"
  
