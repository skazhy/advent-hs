{-|
Module      : Day24
Description : Day 24: Lobby Layout

<https://adventofcode.com/2020/day/24>
-}

module Day24 where

import Advent

import Data.Map (alter, empty)

data Direction = E | W | NW | NE | SW | SE deriving (Show)

parseLine :: String -> [Direction]
parseLine [] = []
parseLine ('e':xs) = E : parseLine xs
parseLine ('w':xs) = W : parseLine xs
parseLine ('s':'e':xs) = SE : parseLine xs
parseLine ('s':'w':xs) = SW : parseLine xs
parseLine ('n':'e':xs) = NE : parseLine xs
parseLine ('n':'w':xs) = NW : parseLine xs

updCoords :: (Int, Int, Int) -> Direction -> (Int, Int, Int)
updCoords (x,y,z) NW = (x, y+1, z-1)
updCoords (x,y,z) NE = (x+1, y, z-1)
updCoords (x,y,z) W = (x-1, y+1, z)
updCoords (x,y,z) E = (x+1, y-1, z)
updCoords (x,y,z) SW = (x-1, y, z+1)
updCoords (x,y,z) SE = (x, y-1, z+1)

flipTile :: Maybe Bool -> Maybe Bool
flipTile (Just True) = Nothing
flipTile _ = Just True

flipTiles :: [[Direction]] -> Int
flipTiles = length . foldl (flip (alter flipTile)) empty . map (foldl updCoords (0,0,0))

main = do
    input <- parsedInput 24 (map parseLine . lines)
    print $ flipTiles input
