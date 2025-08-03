#!/bin/bash -ex

BUMP_OUTPUT=$(go run cmd/bump-version/main.go)

# Initialize an empty array substitute
lines=()
while IFS= read -r line; do
    lines+=("$line")
done <<< "$BUMP_OUTPUT"

OLD_VERSION=${lines[0]}
NEW_VERSION=${lines[1]}

if ! FILES=$(rg -l "${OLD_VERSION}"); then
  echo "No files found matching ${OLD_VERSION}" >&2
  exit 1
fi

rep ${OLD_VERSION} ${NEW_VERSION} ${FILES}
./update.sh
