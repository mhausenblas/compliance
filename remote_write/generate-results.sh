#!/usr/bin/env bash

set -o errexit
set -o errtrace
set -o nounset
set -o pipefail

###############################################################################
### Config

thisrun=$(date +%s)
outputdoc=${thisrun}_remote_write

###############################################################################
### Dependencies checks

if ! [ -x "$(command -v git)" ]
then
  echo "git is not installed" >&2
  exit 1
fi


###############################################################################
### Main

go test --tags=compliance -v ./ > ${GITHUB_WORKSPACE}/results/${outputdoc}
echo "The results are now available in $outputdoc"
