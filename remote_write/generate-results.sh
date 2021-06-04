#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

###############################################################################
### Config

thisrun=$(date +%s)
outputdoc=${GITHUB_WORKSPACE}/results/${thisrun}_remote_write

###############################################################################
### Dependencies checks

if ! [ -x "$(command -v git)" ]
then
  echo "git is not installed" >&2
  exit 1
fi


###############################################################################
### Main

go test --tags=compliance -v ./ > ${outputdoc}
echo "The results are now available in $outputdoc"
git config --global user.name "GitHub Actions"
git config --global user.email "noreply@github.com"
git add ${outputdoc}
if [ ! $(git status --porcelain | tee /dev/fd/2 | wc -c) -eq 0 ]; then
  git commit -m "auto-generated results for remote_write"
  git push
fi
