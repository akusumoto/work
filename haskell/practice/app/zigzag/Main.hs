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
--
--

left_x x = x - 1
left_y y = y + 1
right_x x = x + 1
right_y y = y - 1

left_x_minus_reset _ = 0 
left_y_minus_reset y = y 
left_x_over_reset _ x = x + 2
left_y_over_reset n _ = n - 1
right_x_minus_reset x = x 
right_y_minus_reset _ = 0 
right_x_over_reset n _ = n - 1
right_y_over_reset _ y = y + 2

pos n x y = x + y * n

zigzag_right n i x y arr
    | i == n*n  = arr
    | x >= n    = zigzag_left n i x3 y3 arr
    | y < 0     = zigzag_left n i x2 y2 arr
    | otherwise = zigzag_right n (i+1) x1 y1 arr2
    where
        p = pos n x y
        arr2 = (take p arr) ++ [i] ++ (drop (p+1) arr)
        x1 = right_x x
        y1 = right_y y
        x2 = right_x_minus_reset x
        y2 = right_y_minus_reset y
        x3 = right_x_over_reset n x
        y3 = right_y_over_reset n y

zigzag_left n i x y arr 
    | i == n*n  = arr
    | y >= n    = zigzag_right n i x3 y3 arr
    | x < 0     = zigzag_right n i x2 y2 arr
    | otherwise = zigzag_left n (i+1) x1 y1 arr2
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
        x1 = left_x x
        y1 = left_y y
        x2 = left_x_minus_reset x
        y2 = left_y_minus_reset y
        x3 = left_x_over_reset n x
        y3 = left_y_over_reset n y
        

zigzag :: Int -> [Int]
zigzag n = zigzag_right n 0 0 0 [0 | i <- [1..n*n]]

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
