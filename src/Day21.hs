{-|
Module      : Day21
Description : Day 21: Allergen Assessment

<https://adventofcode.com/2020/day/21>
-}

module Day21 where

import Advent

import Data.Bifunctor (first, second)
import Data.List (isPrefixOf, intersect, intercalate, sortOn, repeat, (\\))
import Control.Monad (join)
import Data.Map (Map, empty, fromList, toList, union, unionWith, elems)
import qualified Data.Map as M

parseLine :: String -> ([String], [String])
parseLine = second (map init . drop 1) . break ("(contains" `isPrefixOf`) . words

-- |Creates allergen map (allergen -> food listing) for a single map entry
allergenMap :: ([String], [String]) -> Map String [String]
allergenMap = fromList . uncurry (zipWith (flip (,))) . first repeat

allergens :: [([String], [String])] -> Map String [String]
allergens = foldl (unionWith intersect) empty . map allergenMap

knownAllergens :: [([String], [String])] -> Map String [String]
knownAllergens =
    cleanup empty . allergens where
    cleanup to from | null from = to
                    | otherwise = cleanup (union to $ M.filter ((== 1) . length) from)
                                          (M.filter (not . null) $ fmap (\\ (join $ elems to)) from)

puzzle1 :: [([String], [String])] -> [String] -> Int
puzzle1 input known =
    foldl (\acc (f,_) -> acc + length (f \\ known)) 0 input

loadInput = parsedInput 21 (map parseLine . lines)

main = do
    input <- loadInput
    let known = knownAllergens input
    print $ puzzle1 input (join $ elems known)
    print $ intercalate "," $ join $ map snd $ sortOn fst $ toList known
