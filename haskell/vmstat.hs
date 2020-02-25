module Main where

-- vmstat.log 
-- 2020-02-25 00:00:25 procs -----------memory---------- ---swap-- -----io---- --system-- -----cpu-----
-- 2020-02-25 00:00:25  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id  wa st 
-- 2020-02-25 00:00:25  0  0 1401944 185212 130404 490940    0    0     0     0  168  328  1  0 100  0  0  
-- 2020-02-25 00:00:26  0  0 1401944 185212 130404 490940    0    0     0     0  176  325  0  0 99   0  0   
-- 1          2         3  4 5       6      7      8         9   10    11    12   13   14 15 16 17  18 19

import System.Environment (getArgs)
import System.IO
import Text.Read (readMaybe)

load' :: String -> IO([String])
load' file = do
        fh <- openFile file ReadMode
        contents <- hGetContents fh
        let ls = lines contents
        return ls

load :: [String] -> IO([String])
load [] = return []
load (f:fs) = do
    ls <- load' f
    lss <- load fs
    return (ls ++ lss)

proc''' :: Maybe Int -> Maybe Int -> [(Int, Int)]
proc''' (Just x) (Just y) = [(x, y)]
proc'''       _        _  = []

proc'' :: [String] -> [(Int,Int)]
proc'' ps 
    | length ps == 19 = proc''' x y
    | otherwise       = []
        where 
            x = readMaybe (ps !! 14) :: Maybe Int
            y = readMaybe (ps !! 15) :: Maybe Int

proc' :: String -> [(Int, Int)]
proc' l = proc'' $ words l

proc :: [String] -> [(Int, Int)]
proc []     = []
proc (l:ls) = (proc' l) ++ (proc ls)

showResult :: [(Int, Int)] -> IO()
showResult [] = return ()
showResult (r:rs) = do
    print r
    showResult rs

main :: IO()
main = do
    args <- getArgs 
    ls <- load args
    showResult $ proc ls
    
