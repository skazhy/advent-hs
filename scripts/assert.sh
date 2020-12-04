#! /usr/bin/env bash

set -e

# Usage: ./assert.sh [day]
TODAY=$(date "+%d" | sed -e 's/0//g')
DAY=${1:-"$TODAY"}

SRC_FILENAME="src/Day$DAY.hs"
TEST_FILENAME="solutions/day$DAY.txt"
cd $(git rev-parse --show-toplevel)

ACTUAL=$(runghc -isrc src/Day$DAY.hs)
EXPECTED=$(cat "$TEST_FILENAME")

if [ "$ACTUAL" != "$EXPECTED" ]; then
  echo "Tests failed for day $DAY"
  echo "--- Expected:"
  echo "$EXPECTED"
  echo '--- Actual:'
  echo "$ACTUAL"
  exit 1
else
  echo "Tests passed for day $DAY"
fi
