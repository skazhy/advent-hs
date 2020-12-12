{-|
Module      : Day12
Description : Day 12: Rain Risk

<https://adventofcode.com/2020/day/12>
-}

module Day12 where

import Advent

data Course =
    Course { coords :: (Int, Int)
           , direction :: (Int, Int)
           } deriving (Show)

startCourse = Course (0,0)

data Navigation = Coords | Waypoint

parseLine :: String -> (Char, Int)
parseLine (x:xs) = (x, read xs)

incrementY :: (Int, Int) -> Int -> (Int, Int)
incrementY (x, y) a = (x, y + a)

incrementX :: (Int, Int) -> Int -> (Int, Int)
incrementX (x, y) a = (x + a, y)

turnRight :: (Int, Int) -> (Int, Int)
turnRight (x, y) = (negate y, x)

turnLeft :: (Int, Int) -> (Int, Int)
turnLeft (x, y) = (y, negate x)

turnAround :: (Int, Int) -> (Int, Int)
turnAround (x, y) = (negate x, negate y)

moveForward :: Course -> Int -> (Int, Int)
moveForward c i =
    (fst (coords c) + fst (direction c) * i, snd (coords c) + snd (direction c) * i)

updateCourse :: Navigation -> Course -> (Char, Int) -> Course
updateCourse Coords c ('N', i) = c { coords = incrementY (coords c) (negate i) }
updateCourse Coords c ('S', i) = c { coords = incrementY (coords c) i }
updateCourse Coords c ('E', i) = c { coords = incrementX (coords c) i }
updateCourse Coords c ('W', i) = c { coords = incrementX (coords c) (negate i) }
updateCourse _ c ('N', i) = c { direction = incrementY (direction c) (negate i) }
updateCourse _ c ('S', i) = c { direction = incrementY (direction c) i }
updateCourse _ c ('E', i) = c { direction = incrementX (direction c) i }
updateCourse _ c ('W', i) = c { direction = incrementX (direction c) (negate i) }
updateCourse _ c ('F', i) = c { coords = moveForward c i }
updateCourse _ c (_, 180) = c { direction = turnAround (direction c) }
updateCourse _ c ('R', 90) = c { direction = turnRight (direction c) }
updateCourse _ c ('R', 270) = c { direction = turnLeft (direction c) }
updateCourse _ c ('L', 90) = c { direction = turnLeft (direction c) }
updateCourse _ c ('L', 270) = c { direction = turnRight (direction c) }
updateCourse _ c _ = c

navigate :: Navigation -> (Int, Int) -> [(Char, Int)] -> Int
navigate navigation dir =
    res . foldl (updateCourse navigation) (startCourse dir)
    where res x =  abs (fst $ coords x) + abs (snd $ coords x)

main = do
    input <- parsedInput 12 (map parseLine . lines)
    print $ navigate Coords (1, 0) input
    print $ navigate Waypoint (10, -1) input
