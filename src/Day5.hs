{-|
Module      : Day5
Description : Day 5: Binary Boarding

<https://adventofcode.com/2020/day/5>
Notes from this puzzle:
* `zipWith ($) functions els` is roughly equivalent to
   `(map #(%1 %2) functions els)`
-}

module Day5 where

import Advent

import Control.Applicative (liftA2)
import Data.List (maximum, sort)
import Data.Maybe (fromMaybe)

rangeDelta :: (Int, Int) -> Int
rangeDelta = (`div` 2) . uncurry subtract

updateRange :: Char -> (Int, Int) -> Char -> (Int, Int)
updateRange low range ch
    | low == ch = (fst range, snd range - rangeDelta range)
    | otherwise = (fst range + rangeDelta range, snd range)

decodeRange :: Char -> Int -> String -> Int
decodeRange lowChar high = fst . foldl (updateRange lowChar) (0, high)

decodeRow = decodeRange 'F' 128
decodeSeat = decodeRange 'L' 8

decodeBoardingPass :: String -> Int
decodeBoardingPass =
    liftA2 (\row seat -> 8 * row + seat) (decodeRow . take 7) (decodeSeat . drop 7)

findFreeSeat :: [Int] -> Maybe Int
findFreeSeat (a:b:xs)
    | a + 1 /= b = Just (a + 1)
    | otherwise = findFreeSeat (b : xs)
findFreeSeat _ = Nothing

main = do
    input <- parsedInput 5 (map decodeBoardingPass . lines)
    print $ maximum input
    print $ (fromMaybe 0 . findFreeSeat . sort ) input
