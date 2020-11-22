#!/bin/sh

# Runs hlint against staged Haskell source file changes.

set -e

cd $(git rev-parse --show-toplevel)
FILES=$(git diff --diff-filter=d --cached --name-only -- "*.hs")

if [ ! -z "$FILES" ]; then
  hlint -q $FILES || hlint $FILES
fi
