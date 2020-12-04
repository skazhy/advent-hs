#! /usr/bin/env bash

set -e

# Usage: ./dev.sh [day]
YEAR=2020
TODAY=$(date "+%d" | sed -e 's/0//g')
DAY=${1:-"$TODAY"}

TODO_FILENAME="TODO.md"

# Add new source file if needed
SRC_FILENAME="src/Day$DAY.hs"
if [ ! -f "$SRC_FILENAME" ]; then
  echo "Creating new source file for day $DAY..."
  TITLE=$(curl -s https://adventofcode.com/$YEAR/day/$DAY | grep -m1 h2 | sed 's/.*--- \(Day .*\) ---.*/\1/')
  cp src/Day0.hs src/Day$DAY.hs
  # Remove / replace 2019.01 specific code.
  sed -i "" "s/Day0/Day$DAY/g; \
             3s/Day.*/$TITLE/; \
             5d; \
             6s:2019/day/1:$YEAR/day/$DAY:; \
             8s/.*/\* /; \
             s/parsedInput 0 intLines/parsedInput $DAY id/; \
             18,24d;  \
             27,28d;" $SRC_FILENAME
  echo "    print input" >> $SRC_FILENAME
  git add --intent-to-add $SRC_FILENAME

  # Append new section to TODO.md if needed.
  if ! grep -q "$TITLE" "$TODO_FILENAME"; then
TODO_CONTENT=$(cat <<-eof

### $TITLE

[puzzle](https://adventofcode.com/$YEAR/day/$DAY) | [source](/$SRC_FILENAME)

*
eof
)
  echo "$TODO_CONTENT" >> "$TODO_FILENAME"
  fi
fi

# Create a new input file if needed
INPUT_FILENAME="inputs/day$DAY.txt"
if [ ! -f "$INPUT_FILENAME" ]; then
  if [ ! -f ".cookie" ]; then
    echo "Please save the cookie header value in .cookie!"
    exit 1
  fi
  curl -s --fail https://adventofcode.com/$YEAR/day/$DAY/input -H "Cookie: $(cat .cookie)" > "$INPUT_FILENAME"
  git add --intent-to-add $INPUT_FILENAME
fi

# Create a solution file if needed
SOLUTION_FILENAME="solutions/day$DAY.txt"
if [ ! -f "$SOLUTION_FILENAME" ]; then
  touch $SOLUTION_FILENAME
  git add --intent-to-add $SOLUTION_FILENAME
fi

# Start GHCi with the selected source file loaded
ghci -isrc $SRC_FILENAME
