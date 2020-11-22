module Advent
    ( readInput
    , parsedInput
    , intLines
    ) where

inputFilename :: Int -> String
inputFilename dayNum =
    "inputs/day" ++ show dayNum ++ ".txt"

readInput :: Int -> IO String
readInput = fmap init . readFile . inputFilename

parsedInput :: Int -> (String -> a) -> IO a
parsedInput dayNum parse =
    parse <$> readInput dayNum

intLines :: String -> [Int]
intLines = map read . lines
