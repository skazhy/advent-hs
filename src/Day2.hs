{-|
Module      : Day2
Description : Day 2: Password Philosophy

<https://adventofcode.com/2020/day/2>
Notes from this puzzle:
* break returns a tuple with two collections.
* !! returns element at index (or throws)

-}

module Day2 where

import Advent

data Password =
    Password { low :: Int
             , high :: Int
             , letter :: Char
             , value :: String
             } deriving (Show)

parseIndex :: String -> Int
parseIndex = abs . read

fromString :: String -> Password
fromString s =
    let [i, l, v] = words s
        indexes = break (== '-') i
    in Password { low = parseIndex $ fst indexes
                , high = parseIndex $ snd indexes
                , letter = head l
                , value = v
                }

isValidPassword :: Password -> Bool
isValidPassword pw =
    (inRange (low pw, high pw) . length . filter (== letter pw) . value) pw

charMatcher :: (Password -> Int) -> Password -> Bool
charMatcher val pw = value pw !! (val pw - 1) == letter pw

isValidPassword2 :: Password -> Bool
isValidPassword2 pw =
    charMatcher low pw /= charMatcher high pw

main = do
    input <- parsedInput 2 (map fromString . lines)
    print $ (length . filter isValidPassword) input
    print $ (length . filter isValidPassword2) input
