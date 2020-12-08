#!/bin/sh

# Runs hlint against a given puzzle's source

set -e

# Usage: ./lint.sh [day]
TODAY=$(date "+%d" | sed -e 's/0//g')
DAY=${1:-"$TODAY"}

SRC_FILENAME="src/Day$DAY.hs"
TEST_FILENAME="solutions/day$DAY.txt"
cd $(git rev-parse --show-toplevel)

git clean -qfdX -- src/{Advent,Day$DAY}.*
hlint -q src/Advent.hs $SRC_FILENAME || hlint src/Advent.hs $SRC_FILENAME
runghc -Werror -Wall -Wno-missing-signatures -isrc $SRC_FILENAME > /dev/null

echo "Code looks good for day $DAY"
