#!/bin/sh

cd "$GITHUB_WORKSPACE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

result_file=$(mktemp)

(brakeman --quiet --format tabs ${INPUT_BRAKEMAN_FLAGS}; echo $? > $result_file) \
  | reviewdog -f=brakeman -name="${INPUT_TOOL_NAME}" -reporter="${INPUT_REPORTER}" -level="${INPUT_LEVEL}"

exit $(cat $result_file)
