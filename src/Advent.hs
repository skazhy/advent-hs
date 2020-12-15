{-# LANGUAGE OverloadedStrings #-}

module Advent
    ( readInput
    , parsedInput
    , intLines
    , intSequence
    , inRange
    , groupedLines
    ) where

import Control.Monad
import qualified Data.Text as T

inputFilename :: Int -> String
inputFilename dayNum =
    "inputs/day" ++ show dayNum ++ ".txt"

readInput :: Int -> IO String
readInput = fmap init . readFile . inputFilename

parsedInput :: Int -> (String -> a) -> IO a
parsedInput dayNum parse =
    parse <$> readInput dayNum

-- Input parsers

intLines :: String -> [Int]
intLines = map read . lines

intSequence :: String -> [Int]
intSequence = map (read . T.unpack) . T.splitOn "," . T.pack

-- Helpers

inRange :: Ord a => (a, a) -> a -> Bool
inRange (low, high) = liftM2 (&&) (>= low) (<= high)

-- |Groups lines in blocks that are separated by a blank line.
groupedLines :: [String] -> [[String]]
groupedLines [] = []
groupedLines (x:xs) =
    (x:ys) : (groupedLines . drop 1) zs
    where (ys,zs) = span (/= "") xs
