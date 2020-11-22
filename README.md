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
My Clojure solutions for (some of) 2017-2019 puzzles are [here](https://github.com/skazhy/advent).

### Workflow

`dev.sh` is the interactive entry point for GHCi-driven development.

When run with no arguments it sets up source and input files for the current day.
Alternatively it can be started with a day number (`dev.sh 20`) to start (or revisit) a
given day. When creating files, the input text & title of a given day need to
be provided.

`Day0` contains puzzles from December 1, 2019 that serve as a template when
setting up new days.

`runghc -isrc src/DayX.hs` can be used to run already completed puzzles.

___

2020 - &infin; [skazhy](http://karlis.me)
