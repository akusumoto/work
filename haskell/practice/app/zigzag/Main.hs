module Main where

import Text.Printf

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
--
--

left_x x = x - 1
left_y y = y + 1
right_x x = x + 1
right_y y = y - 1

next i = i + 1

pos n x y = x + y * n

zigzag_right n i x y arr
    | i == n*n  = arr
    | x >= n    = zigzag_left n i (n-1) (y+2) arr
    | y < 0     = zigzag_left n i x 0 arr
    | otherwise = zigzag_right n (next i) (right_x x) (right_y y) arr2
    where
        p = pos n x y
        arr2 = (take p arr) ++ [i] ++ (drop (p+1) arr)

zigzag_left n i x y arr 
    | i == n*n  = arr
    | y >= n    = zigzag_right n i (x+2) (n-1) arr
    | x < 0     = zigzag_right n i 0 y arr
    | otherwise = zigzag_left n (next i) (left_x x) (left_y y) arr2
    where
        --   p =  0  1  2  3  ...
        -- arr = [a, b, c, d, ...]
        --              |
        --              +-- i = 1
        -- arr2 = [a, b] ++ [1] ++ [d, ...]
        --           |               |
        --           +-- take p arr  +-- drop (p+1) arr
        p = pos n x y
        arr2 = (take p arr) ++ [i] ++ (drop (p+1) arr)

zigzag :: Int -> [Int]
zigzag n = zigzag_right n 0 0 0 [0 | i <- [1..n*n]]

formatNumber i 
    | i < 10    = " " ++ show i
    | otherwise = show i

formatMatrix' _ _ [] = ""
formatMatrix' n 1 (a:arr) = formatNumber a ++ "\n" ++ formatMatrix' n n arr
formatMatrix' n i (a:arr) = formatNumber a ++ " " ++ formatMatrix' n (i-1) arr

formatMatrix n arr = formatMatrix' n n arr

main = putStrLn $ formatMatrix 5 $ zigzag 5
