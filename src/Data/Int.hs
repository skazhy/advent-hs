module Data.Int (ceilDiv) where

infixl 7 `ceilDiv`

ceilDiv :: Int -> Int -> Int
ceilDiv a b =
    case a `divMod` b of
        (r, 0) -> r
        (r, _) -> r + 1
