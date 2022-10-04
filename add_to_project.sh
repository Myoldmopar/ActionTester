#!/bin/bash

# call with two args: the current PR number, and the projectv2 nodeid, which should be an action SECRET

CONTENT=`gh pr view $1 --json 'id' --jq '.id'`

# Need to get Node ID for the issue or PR to add if we do it this way
gh api graphql -f query='
  mutation {
    addProjectV2ItemById(input: {projectId: "$2" contentId: "${CONTENT}"}) {
      item {
        id
      }
    }
  }'
  
