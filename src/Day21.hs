{-|
Module      : Day21
Description : Day 21: Allergen Assessment

<https://adventofcode.com/2020/day/21>
-}

module Day21 where

import Advent

import Data.Bifunctor (first, second)
import Data.List (isPrefixOf, intersect, intercalate, repeat, (\\))
import Data.Map (Map, empty, fromList, union, unionWith, elems)
import qualified Data.Map as M

parseLine :: String -> ([String], [String])
parseLine = second (map init . drop 1) . break ("(contains" `isPrefixOf`) . words

-- |Creates a  map of (allergen name -> ingredient listing) for a single input row
allergenMap :: ([String], [String]) -> Map String [String]
allergenMap = fromList . uncurry (zipWith (flip (,))) . first repeat

allergens :: [([String], [String])] -> Map String [String]
allergens = foldl (unionWith intersect) empty . map allergenMap

knownAllergens :: [([String], [String])] -> Map String String
knownAllergens =
    go empty . allergens where
    go to from | null from = to
               | otherwise = go (union to $ head <$> M.filter ((== 1) . length) from)
                                (M.filter (not . null) $ fmap (\\ elems to) from)

main = do
    input <- parsedInput 21 (map parseLine . lines)
    let known = knownAllergens input
    print $ sum $ map (length . (\\ elems known) . fst) input
    print $ (intercalate "," . elems) known
