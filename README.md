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
external libraries. Most puzzles contain new things learned when solving the
day & [TODO.md](/TODO.md) contain extra challenges and open questions.

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

### Utilities

`./scripts/run.sh [day number]` runs already completed puzzles.

`scripts/lint.sh [day number]` runs [hlint](https://hackage.haskell.org/package/hlint)
and checks for [GHC warnings](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/using-warnings.html).

`./scripts/assert.sh [day number]` compares puzzle output to correct answers
from `solutions/` folder.

___

2020 - &infin; [skazhy](http://karlis.me)
