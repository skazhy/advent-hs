# Notes, extra challenges & open questions

### Day 1: Report Repair

[puzzle](https://adventofcode.com/2020/day/1) | [source](/src/Day1.hs)

We need to find items in the input list that sum up to 2020
(in the 1st puzzle we need to find 2 items, in the 2nd puzzle - 3 items) and
return the product of the found numbers.

`Control.Applicative.<|>` is used to continue searching list, if elements do
not sum up to 2020, `Data.Foldable.asum` is used to take first non-empty
element from the list (which contains the sum).

* `elementResult`: is there a way to return replace `member` lookup with a
  method that returns a Maybe, so that the if-else can be replaced with a map.

### Day 2: Password Philosophy

[puzzle](https://adventofcode.com/2020/day/2) | [source](/src/Day2.hs)

We need to verify if a string ("password") matches predicates for the given
row. For the first puzzle we need to match that given character appears a
certain amount of times. For the 2nd puzzle we need to match that the given
character is only in one of the positions.

Using 2 separate record fields for "high" and "low" values felt too verbose.

* is there an idiomatic way to express `length . filter`?
* try out using tuple for `low` and `high` instead of 2 fields.

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

* ~Do not use ranges in `validateHeight`~

### Day 5: Binary Boarding

[puzzle](https://adventofcode.com/2020/day/5) | [source](/src/Day5.hs)

We are decoding "boarding passes" & finding the biggest boarding pass id &
looking up free seat in the second puzzle.

Decoding is done by halving an int range (represented as tuple) in each step.

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

* Make it less brute-forcey.

### Day 10: Adapter Array

We are scanning the input with a fixed size window & finding whether or not
the window contains numbers with sum equal to the last number in the window.
In part two we are finding a cintiguous set of numbers that sum up to a given
number.

Thanks to `hlint` I was able to simplify my basic monadic ops quite a bit &
use appropriate Kliesli arrows. Other than that, guarded functions made
this easy to implement.

[puzzle](https://adventofcode.com/2020/day/10) | [source](/src/Day10.hs)

*

### Day 11: Seating System

[puzzle](https://adventofcode.com/2020/day/11) | [source](/src/Day11.hs)

*

### Day 12: Rain Risk

[puzzle](https://adventofcode.com/2020/day/12) | [source](/src/Day12.hs)

* Is there a better way to work with tuples? `incrementX` and `incrementY` are
  pretty cumbersome.
* Declutter the patterns in `updateCourse`

### Day 13: Shuttle Search

[puzzle](https://adventofcode.com/2020/day/13) | [source](/src/Day13.hs)

*
