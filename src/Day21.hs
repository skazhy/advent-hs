{-|
Module      : Day21
Description : Day 21: Allergen Assessment

<https://adventofcode.com/2020/day/21>
-}

module Day21 where

import Advent

import Control.Monad (join)
import Data.Bifunctor (first, second)
import Data.List (isPrefixOf, intersect, intercalate, sortOn, repeat, (\\))
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
    go empty . allergens where
    go to from | null from = to
               | otherwise = go (union to $ M.filter ((== 1) . length) from)
                                (M.filter (not . null) $ fmap (\\ (join $ elems to)) from)

main = do
    input <- parsedInput 21 (map parseLine . lines)
    let known = knownAllergens input
    print $ sum $ map (length . (\\ (join $ elems known)) . fst) input
    print $ (intercalate "," . join . map snd . sortOn fst . toList) known