module Main where

import System.Environment (getArgs)

--  y\x|  0  1  2  3  4
-- ----+---------------- 
--     |         (7)
--     |          ^ 
--     |         / right
--  0  |  0  1  5  6 14
--     |    /   ^ 
--    left /   / right
--     |  v   / 
--  1  |  2  4  7 13 15 (22)
--     |     ^           ^ 
--     |    / right     / right   
--     |   /           /
--  2  |  3  8 12 16 21 
--     |              ^
--     |       right / 
--     |            /
--  3  |  9 11 17 20 22
--     |           ^ /
--     |    right / / left
--     |         / v 
--  4  | 10 18 19 23 24
--     |          / left
--     |         v
--     |       (24) 

--   p =  0  1  2  3  ...
-- arr = [a, b, c, d, ...]
--              |
--              +-- i = 1
-- arr2 = [a, b] ++ [1] ++ [d, ...]
--           |               |
--           +-- take p arr  +-- drop (p+1) arr

pos n x y = x + y * n

zigzagr n i x y arr
    | i == n*n  = arr
    | x >= n    = zigzagl n i (n-1) (y+2) arr
    | y < 0     = zigzagl n i x 0 arr
    | otherwise = zigzagr n (i+1) (x+1) (y-1) arr2
    where
        p = x + y * n
        arr2 = (take p arr) ++ [i] ++ (drop (p+1) arr)

zigzagl n i x y arr 
    | i == n*n  = arr
    | y >= n    = zigzagr n i (x+2) (n-1) arr
    | x < 0     = zigzagr n i 0 y arr
    | otherwise = zigzagl n (i+1) (x-1) (y+1) arr2
    where
        p = x + y * n
        arr2 = (take p arr) ++ [i] ++ (drop (p+1) arr)
        

zigzag :: Int -> [Int]
zigzag n = zigzagr n 0 0 0 [0 | i <- [1..n*n]]

space 0 = ""
space n = " " ++ space (n-1)

formatNumber n i = space (length (show (n*n-1)) - length (show i)) ++ show i

formatMatrix' _ _ [] = ""
formatMatrix' n 1 (a:arr) = formatNumber n a ++ "\n" ++ formatMatrix' n n arr
formatMatrix' n i (a:arr) = formatNumber n a ++ " " ++ formatMatrix' n (i-1) arr

formatMatrix n arr = formatMatrix' n n arr

main = do
    args <- getArgs
    putStrLn $ formatMatrix (read $ args !! 0) $ zigzag (read $ args !! 0)
