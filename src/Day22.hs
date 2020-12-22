{-|
Module      : Day22
Description : Day 22: Crab Combat

<https://adventofcode.com/2020/day/22>
-}

module Day22 where

import Advent

import Data.Bifunctor (bimap)

parseData :: [String] -> ([Int], [Int])
parseData = bimap (map read . tail) (map read . drop 2) . span (/= "")

playTurn :: ([Int], [Int]) -> ([Int], [Int])
playTurn (x:xs, y:ys)
    | x > y = (xs ++ [x,y], ys)
    | otherwise = (xs, ys ++ [y,x])
playTurn e = e

-- |Plays turns until one of the players has an empty hand
playGame :: ([Int], [Int]) -> ([Int], [Int])
playGame = head . dropWhile (not . all null) . iterate playTurn

handScore :: [Int] -> Int
handScore = sum . zipWith (*) [1..] . reverse

main = do
    input <- parsedInput 22 (parseData . lines)
    print $ (uncurry (+) . bimap handScore handScore . playGame) input
