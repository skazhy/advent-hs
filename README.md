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
Main repository for AoC solutions (which includes these as well) [is here](https://github.com/skazhy/advent).

My goal for Advent of Code 2020 is to explore core Haskell & not use any
external libraries. Most puzzles contain new things learned when solving the
day & [NOTES.md](/NOTES.md) contain puzzle notes, extra challenges, and open questions.

## Workflow

`./dev.sh` script is the one-stop for interactive development.

```
./dev.sh day-number [assert] [lint]
```

Running it with no optional args, script starts a GHCi session & pulls input
data (adventofcode.com session cookie value needs to be stored
in a `.cookie` file. Saves me 10 seconds every day, I know).

* `assert` compares puzzle output correct answers from [solutions](/solutions) folder
* `lint` runs [hlint](https://hackage.haskell.org/package/hlint) and checks
  for [GHC warnings](https://downloads.haskell.org/~ghc/latest/docs/html/users_guide/using-warnings.html).

___

2020 - &infin; [skazhy](http://karlis.me)
