#! /usr/bin/env bash

# One-stop shop for developing and testing AoC puzzles in Haskell.
# Usage: ./dev.sh [day] [lint] [assert]
#
# When run with no options, opens GHCi for given day number. Defaults to
# current day if no day number is provied.
# * lint: runs HLint & checks for GHC errors
# * assert: compares output to correct solutions

set -e

YEAR=2020
DAY=$(date "+%d" | sed -e 's/^0//g')

GHC_FLAGS=""

while :
do
  case "${1-}" in
    [0-9]*)
      DAY=$1
      shift
      ;;
    lint)
      LINT=1
      GHC_FLAGS="-Werror -Wall -Wno-missing-signatures"
      shift
      ;;
    assert)
      ASSERT=1
      shift
      ;;
  *)
    break
    ;;
  esac
done

PUZZLE_URL="https://adventofcode.com/$YEAR/day/$DAY"

# Filenames
TODOS_FILE="NOTES.md"
SRC_FILE="src/Day$DAY.hs"
INPUT_FILE="inputs/day$DAY.txt"
SOLUTION_FILE="solutions/day$DAY.txt"

function update_todos_file {
  if ! grep -q "$TITLE" "$TODOS_FILE"; then
    local TODO_CONTENT=$(cat <<-eof

### $TITLE

[puzzle]($PUZZLE_URL) | [source](/$SRC_FILE)

*
eof
)
echo "$TODO_CONTENT" >> "$TODOS_FILE"
  fi
}

function gen_src_file {
  if [ ! -f "$SRC_FILE" ]; then
    echo "Creating new source file for day $DAY..."
    cp src/Day0.hs src/Day$DAY.hs
    # Remove / replace 2019.01 specific code.
    sed -i "" "s/Day0/Day$DAY/g; \
               3s/Day.*/$TITLE/; \
               5d; \
               6s:2019/day/1:$YEAR/day/$DAY:; \
               s/parsedInput 0 intLines/parsedInput $DAY lines/; \
               15,21d;  \
               24,25d;" $SRC_FILE
    echo "    print input" >> $SRC_FILE
    git add --intent-to-add $SRC_FILE
  fi
}

function fetch_input_file {
  set -e
  if [ ! -f "$INPUT_FILE" ]; then
    if [ ! -f ".cookie" ]; then
      echo "Please save the cookie header value in .cookie!"
      exit 1
    fi
    curl --fail -s "$PUZZLE_URL/input" -H "Cookie: $(cat .cookie)" > "$INPUT_FILE" || \
      (echo "Error: please refresh .cookie!" && rm -f "$INPUT_FILE" && exit 1)
    git add --intent-to-add $INPUT_FILE
  fi
}

function gen_solution_file {
if [ ! -f "$SOLUTION_FILE" ]; then
  touch $SOLUTION_FILE
  git add --intent-to-add $SOLUTION_FILE
fi
}

[ "$LINT" ] && hlint src/Advent.hs src/Data $SRC_FILE
[ "$LINT" ] || [ "$ASSERT" ] && ACTUAL=$(runghc $GHC_FLAGS -isrc $SRC_FILE)

if [[ "$ASSERT" ]]; then
  EXPECTED=$(cat "$SOLUTION_FILE")
  if [ "$ACTUAL" != "$EXPECTED" ]; then
    echo "Tests failed for day $DAY"
    echo "--- Expected:"
    echo "$EXPECTED"
    echo '--- Actual:'
    echo "$ACTUAL"
    exit 1
  else
    echo "$ACTUAL"
    echo "Tests passed for day $DAY"
  fi
fi

if [[ ! "$LINT" && ! "$ASSERT" ]]; then
  TITLE=$(curl -s $PUZZLE_URL | grep -m1 h2 | sed 's/.*--- \(Day .*\) ---.*/\1/')
  gen_src_file
  update_todos_file
  fetch_input_file
  gen_solution_file
  ghci -isrc $SRC_FILE
fi
