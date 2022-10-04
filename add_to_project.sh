#!/bin/bash

# call with the PR number and the project id as 2 command line arguments

PR_NUM=$1
PROJ_ID=$2
echo "Using PR Num as ${PR_NUM} and project ID as: ${PROJ_ID}"

CONTENT=`gh pr view $1 --json 'id' --jq '.id'`
echo "Found PR node ID as: ${CONTENT}"

# Need to get Node ID for the issue or PR to add if we do it this way
gh api graphql -f query="
  mutation {
    addProjectV2ItemById(input: {projectId: ${PROJ_ID} contentId: ${CONTENT}}) {
      item {
        id
      }
    }
  }"
  
