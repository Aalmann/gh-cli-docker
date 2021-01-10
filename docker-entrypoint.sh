#!/bin/bash

if [[ -z "$GH_API_TOKEN" ]]; then 
    echo Please provide a GitHub API token.
    exit 1
fi

echo login to GitHub using given API token
gh auth login -w ${GH_API_TOKEN}

echo Successfully logged in
echo Calling gh $@

gh $@
