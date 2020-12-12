# Extra challenges & open questions

### Day 1: Report Repair

[puzzle](https://adventofcode.com/2020/day/1) | [source](/src/Day1.hs)

* `elementResult`: is there a way to return replace `member` lookup with a
  method that returns a Maybe, so that the if-else can be replaced with a map.

### Day 2: Password Philosophy

[puzzle](https://adventofcode.com/2020/day/2) | [source](/src/Day2.hs)

* is there an idiomatic way to express `length . filter`?

### Day 3: Toboggan Trajectory

[puzzle](https://adventofcode.com/2020/day/3) | [source](/src/Day3.hs)

* `updateCoords`:  Can it be expressed in point-free style? How would Haskell
  version of `(map + [1 2] [3 4])` look like?

### Day 4: Passport Processing

[puzzle](https://adventofcode.com/2020/day/4) | [source](/src/Day4.hs)

* ~Do not use ranges in `validateHeight`~

### Day 5: Binary Boarding

[puzzle](https://adventofcode.com/2020/day/5) | [source](/src/Day5.hs)

* ~Is there a better way to do destructuring in `decodeBoardingPass` (so that
  `head` is not needed)?~
* Try using `splitAt 7` in `decodeBoardingPass` instead of drop + take
* What's the idiomatic way to transform lists to tuples?
* Try rewriting `decodeRange` with recursion.

### Day 6: Custom Customs

[puzzle](https://adventofcode.com/2020/day/6) | [source](/src/Day6.hs)

* ~`parseLines` should be moved to generic helpers.~

### Day 7: Handy Haversacks

[puzzle](https://adventofcode.com/2020/day/7) | [source](/src/Day7.hs)

* `sumOfChildren` and it's fold step can be improved.

### Day 8: Handheld Halting

[puzzle](https://adventofcode.com/2020/day/8) | [source](/src/Day8.hs)

* `runInstruction` could be improved, looks a bit noisy now.

### Day 9: Encoding Error

[puzzle](https://adventofcode.com/2020/day/9) | [source](/src/Day9.hs)

* Make it less brute-forcey.

### Day 10: Adapter Array

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
