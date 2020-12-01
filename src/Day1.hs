{-|
Module      : Day1
Description : Day 1: Report Repair

<https://adventofcode.com/2020/day/1>

-}

module Day1 where

import Advent

import Control.Applicative
import Data.Foldable (asum, find)
import Data.Set (Set(..), fromList, member)

elementResult :: Set Int -> [Int] -> Maybe Int
elementResult itemSet els =
    let el = (2020 - (sum els)) in
    if member el itemSet
       then Just $ foldr (*) el els
       else Nothing

tripletResult :: Set Int -> [Int] -> Int -> Maybe Int
tripletResult itemSet (x:xs) y =
    elementResult itemSet [x, y] <|> tripletResult itemSet xs y
tripletResult itemSet [] _ = Nothing

puzzle1 :: [Int] -> Maybe Int
puzzle1 items =
    let itemSet = fromList items
    in asum $ fmap ((elementResult itemSet) . return) items

puzzle2 :: [Int] -> Maybe Int
puzzle2 input =
    let itemSet = fromList input
    in asum $ map (tripletResult itemSet input) input

main = do
    items <- parsedInput 1 intLines
    let itemSet = fromList items
    print $ puzzle1 items
    print $ puzzle2 items
