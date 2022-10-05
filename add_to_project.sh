#!/bin/bash

# call with the PR number as the only command line argument
# soon it will be 3, with the addition of a project id stored as a secret, and an event type to handle
# for now this just adds the current PR to the specified project

# get the PR num from the command line argument
PR_NUM=$1
PROJ_ID=PVT_kwHOAAz3oM4AGYkT
echo "Using PR Num as ${PR_NUM} and project ID as: ${PROJ_ID}"

# get the current PR number based on the this checkout
CONTENT=`gh pr view $1 --json 'id' --jq '.id'`
echo "Found PR node ID as: ${CONTENT}"

# use the gh api command line to act on the Projectv2 API and add the PR as a new card
# should also add more arguments for the column to use, etc.
gh api graphql -f query="
  mutation {
    addProjectV2ItemById(input: {projectId: \"${PROJ_ID}\" contentId: \"${CONTENT}\"}) {
      item {
        id
      }
    }
  }"
