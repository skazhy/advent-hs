#! /usr/bin/env bash

set -e

# Usage: ./dev.sh [day]
TODAY=$(date "+%d" | sed -e 's/0//g')
DAY=${1:-"$TODAY"}

# Add new source file if needed
SRC_FILENAME="src/Day$DAY.hs"
if [ ! -f "$SRC_FILENAME" ]; then
  echo "Creating new source file for day $DAY..."
  cp src/Day0.hs src/Day$DAY.hs
  sed -i "" "s/Day0/Day$DAY/g" $SRC_FILENAME
  # Remove 2019.01 specific code from template.
  sed -i "" "s/parsedInput 0 intLines/parsedInput $DAY id/g" $SRC_FILENAME
  sed -i "" "7,13d;16,17d" $SRC_FILENAME
  echo "    print input" >> $SRC_FILENAME
  git add --intent-to-add $SRC_FILENAME
fi

# Create a new input file if needed
INPUT_FILENAME="inputs/day$DAY.txt"
if [ ! -f "$INPUT_FILENAME" ]; then
  vim $INPUT_FILENAME
  git add --intent-to-add $INPUT_FILENAME
fi

# Start GHCi with the new file loaded
ghci -isrc $SRC_FILENAME
