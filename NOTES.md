# Notes, extra challenges & open questions

### Day 1: Report Repair

[puzzle](https://adventofcode.com/2020/day/1) | [source](/src/Day1.hs)

We need to find items in the input list that sum up to 2020
(in the 1st puzzle we need to find 2 items, in the 2nd puzzle - 3 items) and
return the product of the found numbers.

`Control.Applicative.<|>` is used to continue searching list, if elements do
not sum up to 2020, `Data.Foldable.asum` is used to take first non-empty
element from the list (which contains the sum). It is not possible to pattern
match on sets, so both sets and lists are used.

* `elementResult`: is there a way to return replace `member` lookup with a
  method that returns a Maybe, so that the if-else can be replaced with a map.

### Day 2: Password Philosophy

[puzzle](https://adventofcode.com/2020/day/2) | [source](/src/Day2.hs)

We need to verify if a string ("password") matches predicates for the given
row. For the first puzzle we need to match that given character appears a
certain amount of times. For the 2nd puzzle we need to match that the given
character is only in one of the positions.

Using 2 separate record fields for "high" and "low" values felt too verbose -
I have refactored it to use `(Int,Int)` and discovered `Data.Bifunctor` which
makes working with tuples much easier.

* is there an idiomatic way to express `length . filter`?
~* try out using tuple for `low` and `high` instead of 2 fields.~

### Day 3: Toboggan Trajectory

[puzzle](https://adventofcode.com/2020/day/3) | [source](/src/Day3.hs)

We need to traverse a circular ASCII maze. In the first puzzle we traverse
down with a constant move in every turn and count "trees" along the way. In
the second puzzle we traverse with various moves & return a product of trees
along the way across all traverses.

We use `fromEnum` to count all `True` values in a list - map is represented as
vector of Strings (which ended up being a bit awkward to query).

* try representing the map as `Map (Int, Int) Bool` (similar as in [day 12](#day-12-rain-risk)).
* `updateCoords`:  Can it be expressed in point-free style? How would Haskell
  version of `(map + [1 2] [3 4])` look like?

### Day 4: Passport Processing

[puzzle](https://adventofcode.com/2020/day/4) | [source](/src/Day4.hs)

We Need to validate that each paragraph of input ("passport data") matches
given predicates. In the first puzzle we check for the presence of fields and
in the second puzzle we validate field values as well.

Straight-forward task with pattern matching & guards. `liftM2` is used to
filter out items that match both predicates in a list of passports.

I learned about `where` + recursion pattern by reading `groupBy` source, this
has been used a lot in other puzzles.

Items in `fromDistinctAscList` actually need to be in order, or they won't be
included in the resulting set.

* ~Do not use ranges in `validateHeight`~

### Day 5: Binary Boarding

[puzzle](https://adventofcode.com/2020/day/5) | [source](/src/Day5.hs)

We are decoding "boarding passes" & finding the biggest boarding pass id &
looking up free seat in the second puzzle.

Decoding is done by halving an int range (represented as tuple) in each step.

`zipWith ($) functions els` is roughly equivalent to `(map #(%1 %2) functions els)`

* ~Is there a better way to do destructuring in `decodeBoardingPass` (so that
  `head` is not needed)?~
* Try using `splitAt 7` in `decodeBoardingPass` instead of drop + take
* What's the idiomatic way to transform lists to tuples?
* Try rewriting `decodeRange` with recursion.

### Day 6: Custom Customs

[puzzle](https://adventofcode.com/2020/day/6) | [source](/src/Day6.hs)

Each paragraph contains "answers to questions" and we are counting unique
answers in puzzle 1 & counting inersections of answers in puzzle 1.

* ~`parseLines` should be moved to generic helpers.~

### Day 7: Handy Haversacks

[puzzle](https://adventofcode.com/2020/day/7) | [source](/src/Day7.hs)

We are building a graph of "bag dependencies" and traversing in 2 different
w Graph is represnented as `Map String [(String, Int)]` where value string is
the dependency field name & int is the number of "dependency bags".

Data is being parsed only partially, so it's easier to inverse the graph for
puzzle 1.

`TupleSections` extension is used in order to section a tuple which is a handy
shortcut in this puzzle: ` (\x -> (x, 1)) $ 10` can be shortened to `(,1) $
10`.

* `sumOfChildren` and it's fold step can be improved.

### Day 8: Handheld Halting

[puzzle](https://adventofcode.com/2020/day/8) | [source](/src/Day8.hs)

We are running opcode instructions (that change register value & jump to other
instructions) and try to detect infinite loop & find which instruction causes
infinite loop.

Both instructions (`nop`, `jmp`, `acc`) and halting conditions (halting
because of end of program & halting because of infinite loops) are represented
in a single data type for easier pattern matching.

* `runInstruction` could be improved, looks a bit noisy now.

### Day 9: Encoding Error

[puzzle](https://adventofcode.com/2020/day/9) | [source](/src/Day9.hs)

We are scanning the input with a fixed size window & finding whether or not
the window contains numbers with sum equal to the last number in the window.
In part two we are finding a cintiguous set of numbers that sum up to a given
number.

Thanks to `hlint` I was able to simplify my basic monadic ops quite a bit &
use appropriate Kliesli arrows. Other than that, guarded functions made
this easy to implement. Some composition options discovered:
`finally $ this input >>= that` =  `finally . (that =<<) . this` = `finally . (this <=< that)`

* Make it less brute-forcey.

### Day 10: Adapter Array

[puzzle](https://adventofcode.com/2020/day/10) | [source](/src/Day10.hs)

We are computing deltas for a sorted set of integers ("adapters"), the result
is product of delta sums.

For the second puzzle, we are computing the number of various combinations we
can combine "adapters" to get from 0 to max + 3. In each step, the number of
paths to given is computed & we cons this information to accumulator for
lookup in later branches.

### Day 11: Seating System

[puzzle](https://adventofcode.com/2020/day/11) | [source](/src/Day11.hs)

A game of life with a twist - along with basic GoL rules, we have some dead
spaces which can't be occupied. In both puzzles we look for equilibrium states
with differing rules on when a cell ("seat") can be freed.

Grid is represented as `Map [Int] Seat` List was preferred over tuples, so
neighbor cells could be looked up easier.

Some notable simplifications from `hlint`:

* `zipWith (,)` => `zip`
* `foo >>= id` => `Control.Monad.join foo`

### Day 12: Rain Risk

[puzzle](https://adventofcode.com/2020/day/12) | [source](/src/Day12.hs)

We are moving a point in 2D grid & follow a set of instructions that change
its coords. Coords are represented as `(Int, Int)` and both puzzles are pretty
much a single pattern matched method.

* ~Is there a better way to work with tuples? `incrementX` and `incrementY` are
  pretty cumbersome.~ Refactored to use `Data.Bifunctor`
* Declutter the patterns in `updateCourse`

### Day 13: Shuttle Search

[puzzle](https://adventofcode.com/2020/day/13) | [source](/src/Day13.hs)

Puzzle 1 is basic arithmetic, puzzle 2 is implementation of Chinese Remainder
theorem (and extended Euclidean algorithm as the dependency).

A custom division method was required, since `div` always rounds down & puzzle
1 required `ceil` rounding.

### Day 14: Docking Data

[puzzle](https://adventofcode.com/2020/day/14) | [source](/src/Day14.hs)

We are parsing binary numbers and doing bitwise operations in puzzle 1 and
generating numbers by bit-flipping in puzzle 2.

Initially I wrote whole parsing logic for this that batched all operations
together with their relevant mask, but I ended up removing it in favor of
folding over all input data which looks much cleaner.

### Day 15: Rambunctious Recitation

[puzzle](https://adventofcode.com/2020/day/15) | [source](/src/Day15.hs)

Re-implementation my [Clojure solution](https://github.com/skazhy/advent/blob/master/src/advent/2020/day15.clj)
was causing stack overflow errors, so I implemented it with [van Eck
sequence](https://www.youtube.com/watch?v=etMJxB-igrc).

* Fix stack overflow errors that still plague the current implementation for
  puzzle 2 input
