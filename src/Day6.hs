{-|
Module      : Day6
Description : Day 6: Custom Customs

<https://adventofcode.com/2020/day/6>
-}

module Day6 where

import Advent
import Data.List (intersect)
import Data.Set (fromList)

parseLines :: [String] -> [[String]]
parseLines [] = []
parseLines (x:xs) =
    (x:ys) : (parseLines . drop 1) zs
    where (ys,zs) = span (/= "") xs

main = do
    input <- parsedInput 6 (parseLines . lines)
    print $ (sum . map (length . fromList . foldl1 (++))) input
    print $ (sum . map (length . foldl1 intersect)) input
