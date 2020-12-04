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
