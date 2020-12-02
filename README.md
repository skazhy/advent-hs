# Advent of Code 2020

```
                  *
                 /.\
                /..'\
                /'.'\
               /.''.'\
               /.'.'.\
        "'""""/'.''.'.\""'"'"
          >λ= ^^^[_]^^^
```

Haskell solutions to [Advent of Code 2020](https://adventofcode.com/2020).
My Clojure solutions for (some of) 2017-2020 puzzles are [here](https://github.com/skazhy/advent).

My goal for Advent of Code 2020 is to explore core Haskell & not use any
external libraries.

### Workflow

`dev.sh` is the interactive entry point for GHCi-driven development.

When run with no arguments it sets up source and input files for the current day.
Alternatively it can be started with a day number (`dev.sh 20`) to start (or revisit) a
given day. The script load module for the given day in GHCi and pull puzzle data
& title when launching a day for the first time. In order to do that the
adventofcode.com session cookie value needs to be stored in a `.cookie` file
(saves me 10 seconds every day, I know).

`Day0` contains puzzles from December 1, 2019 that serve as a template when
setting up new days.

`./scripts/run.sh [day number]` can be used to run already completed puzzles.

`scripts/lint.sh` runs [hlint](https://hackage.haskell.org/package/hlint) on
staged changes (useful for pre-commit hook).

___

2020 - &infin; [skazhy](http://karlis.me)
