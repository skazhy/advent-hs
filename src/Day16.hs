{-|
Module      : Day16
Description : Day 16: Ticket Translation

<https://adventofcode.com/2020/day/16>
-}

module Day16 where

import Advent

import Control.Monad
import Data.Bifunctor (bimap, second)
import Data.List (intersect, isPrefixOf, transpose, find, delete)

-- Parse

parseRange :: String -> (Int -> Bool)
parseRange = inRange . bimap read (read . tail) . span (/= '-')

parseRanges :: String -> (Int -> Bool)
parseRanges s =
    let [r, _, r2] = words s
    in liftM2 (||) (parseRange r) (parseRange r2)

parseRangeRow :: String -> (String, Int -> Bool)
parseRangeRow = second (parseRanges . tail) . span (/= ':')

anyFieldMatches :: [(String, Int -> Bool)] -> Int -> Bool
anyFieldMatches checkers = or . mapM snd checkers

-- Puzzle 1: Finding invalid elements in each row

puzzle1 :: [(String, Int -> Bool)] -> [[Int]] -> Int
puzzle1 fields = sum . concatMap (filter (not . anyFieldMatches fields))

-- Puzzle 2: Solving the train ticket sudoku

fieldChoices :: [(String, Int -> Bool)] -> Int -> [String]
fieldChoices fields i = map fst $ filter (\(_, m) -> m i) fields

uniqueFieldChoices fields =
    map (foldl1 intersect) . transpose . map (map (fieldChoices fields))

findUnique :: [(Int, [String])] -> [(Int, String)]
findUnique choices =
    case find ((== 1) . length . snd) choices of
        Just (idx, [r]) -> (idx, r) : findUnique (filter ((/= idx) . fst) $ map (second (delete r)) choices)
        _ -> []

departureFields :: [(Int, String)] -> [Int]
departureFields = map fst . filter (("departure" `isPrefixOf`) . snd)

fieldIndexes fields tickets =
    departureFields . findUnique $ zip [0..] $ uniqueFieldChoices fields tickets

puzzle2 :: [(String, Int -> Bool)] -> [Int] -> [[Int]] -> Int
puzzle2 fields ticket nearby =
    let matcher = anyFieldMatches fields
    in product $ map (ticket !!) $ fieldIndexes fields $ filter (all matcher) nearby

main = do
    (fs:ticket:nearby:_) <- parsedInput 16 (groupedLines . lines)
    let fields = map parseRangeRow fs
    print $ puzzle1 fields (map intSequence (tail nearby))
    print $ puzzle2 fields (intSequence (last ticket)) (map intSequence (tail nearby))
