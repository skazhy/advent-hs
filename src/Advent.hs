module Advent
    ( readInput
    , parsedInput
    , intLines
    , inRange
    ) where

import Control.Monad
import Control.Monad.Reader

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

-- Helpers

inRange :: Ord a => (a, a) -> a -> Bool
inRange (low, high) = liftM2 (&&) (>= low) (<= high)
