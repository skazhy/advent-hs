#! /usr/bin/env bash

set -e

# Usage: ./dev.sh [day]
TODAY=$(date "+%d" | sed -e 's/0//g')
DAY=${1:-"$TODAY"}

# Add new source file if needed
SRC_FILENAME="src/Day$DAY.hs"
if [ ! -f "$SRC_FILENAME" ]; then
  echo "Creating new source file for day $DAY..."
  TITLE=$(curl -s https://adventofcode.com/2020/day/$DAY | grep -m1 h2 | sed 's/.*--- \(Day .*\) ---.*/\1/')
  cp src/Day0.hs src/Day$DAY.hs
  sed -i "" "s/Day0/Day$DAY/g; s/TODO/$TITLE/" $SRC_FILENAME

  # Remove 2019.01 specific code from template.
  sed -i "" "s/parsedInput 0 intLines/parsedInput $DAY id/; s:day/0:day/$DAY:; 5d;16,22d;25,26d" $SRC_FILENAME
  echo "    print input" >> $SRC_FILENAME
  git add --intent-to-add $SRC_FILENAME
fi

# Create a new input file if needed
INPUT_FILENAME="inputs/day$DAY.txt"
if [ ! -f "$INPUT_FILENAME" ]; then
  if [ ! -f ".cookie" ]; then
    echo "Please save the cookie header value in .cookie!"
    exit 1
  fi
  COOKIE=$(cat .cookie)
  INPUT=$(curl -s --fail https://adventofcode.com/2019/day/$DAY/input -H "Cookie: $COOKIE")
  echo "$INPUT" > $INPUT_FILENAME
  git add --intent-to-add $INPUT_FILENAME
fi

# Start GHCi with the new file loaded
ghci -isrc $SRC_FILENAME
