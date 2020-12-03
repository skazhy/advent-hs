{-|
Module      : Day3
Description : Day 3: Toboggan Trajectory

<https://adventofcode.com/2020/day/3>
Notes from this puzzle:
* `foldl (*) 1 x` can be rewritten as `product x`

-}

module Day3 where

import Advent

type Coords = (Int, Int)

data Area =
    Area { areaMap :: [String]
         , areaWidth :: Int
         , areaHeight :: Int
         } deriving (Show)

fromString :: String -> Area
fromString areaStr =
    let am = lines areaStr
    in Area { areaMap = am
            , areaWidth = (length . head) am
            , areaHeight = length am
            }

isTree :: Coords -> Area -> Bool
isTree (x, y) = (== '#') . (!! x) . (!! y) . areaMap

updateCoords :: Area -> Coords -> Coords -> Coords
updateCoords area (x, y) (dx, dy) =
    ((`mod` areaWidth area) $ x + dx, y + dy)

traverseArea :: Area -> Coords -> Coords -> Int
traverseArea area coords delta
    | snd coords < areaHeight area =
        traverseArea area (updateCoords area coords delta) delta + (if isTree coords area then 1 else 0)
    | otherwise = 0

puzzle1 :: Area -> Int
puzzle1 area = traverseArea area (0, 0) (3, 1)

puzzle2 :: Area -> Int
puzzle2 area =
    product $ map (traverseArea area (0, 0)) [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]

main = do
    input <- parsedInput 3 fromString
    print $ puzzle1 input
    print $ puzzle2 input
