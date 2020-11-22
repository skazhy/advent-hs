#! /usr/bin/env bash

set -e

# Usage: ./run.sh [day]
TODAY=$(date "+%d" | sed -e 's/0//g')
DAY=${1:-"$TODAY"}

SRC_FILENAME="src/Day$DAY.hs"
cd $(git rev-parse --show-toplevel)

if [ -f "$SRC_FILENAME" ]; then
  runghc -isrc src/Day$DAY.hs
else
  echo "No puzzles for day $DAY"
  exit 1
fi
