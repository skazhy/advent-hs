{-|
Module      : Day0
Description : TODO

Puzzle from December 1, 2019 that serves as a template for 2020 puzzles.
<https://adventofcode.com/2020/day/0>

-}

module Day0 where

import Advent

loadInput = parsedInput 0 intLines

fuel :: Int -> Int
fuel = max 0 . subtract 2 . (`div` 2)

combinedFuel :: Int -> Int
combinedFuel i =
    sum $ takeWhile (> 0) $ tail $ iterate fuel i

main = do
    input <- loadInput
    print $ (sum . map fuel) input
    print $ (sum . map combinedFuel) input
