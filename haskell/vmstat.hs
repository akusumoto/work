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

proc''' :: String -> String -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> Maybe Int
                            -> [(String, String, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int)]
proc''' date time (Just proc_r)
                  (Just proc_b)
                  (Just mem_swap)
                  (Just mem_free)
                  (Just mem_buff)
                  (Just mem_cache) 
                  (Just swap_si) 
                  (Just swap_so) 
                  (Just io_bi) 
                  (Just io_bo) 
                  (Just sys_in) 
                  (Just sys_cs) 
                  (Just cpu_us) 
                  (Just cpu_sy) 
                  (Just cpu_id) 
                  (Just cpu_wa) 
                  (Just cpu_st) = [(date, time, proc_r, proc_b, mem_swap, mem_free, mem_buff, mem_cache, swap_si, swap_so, io_bi, io_bo, sys_in, sys_cs, cpu_us, cpu_sy, cpu_id, cpu_wa, cpu_st)]
proc''' date time _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ = []

proc'' :: [String] -> [(String, String, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int)]
proc'' ps 
    | length ps == 19 = proc''' date
                                time
                                proc_r
                                proc_b
                                mem_swap
                                mem_free
                                mem_buff
                                mem_cache
                                swap_si
                                swap_so
                                io_bi
                                io_bo
                                sys_in
                                sys_cs
                                cpu_us
                                cpu_sy
                                cpu_id
                                cpu_wa
                                cpu_st
    | otherwise       = []
        where 
            date = ps !! 0
            time = ps !! 1
            proc_r = readMaybe (ps !! 2) :: Maybe Int
            proc_b = readMaybe (ps !! 3) :: Maybe Int
            mem_swap  = readMaybe (ps !! 4) :: Maybe Int
            mem_free  = readMaybe (ps !! 5) :: Maybe Int
            mem_buff  = readMaybe (ps !! 6) :: Maybe Int
            mem_cache = readMaybe (ps !! 7) :: Maybe Int
            swap_si = readMaybe (ps !! 8) :: Maybe Int
            swap_so = readMaybe (ps !! 9) :: Maybe Int
            io_bi  = readMaybe (ps !! 10) :: Maybe Int
            io_bo  = readMaybe (ps !! 11) :: Maybe Int
            sys_in = readMaybe (ps !! 12) :: Maybe Int
            sys_cs = readMaybe (ps !! 13) :: Maybe Int
            cpu_us = readMaybe (ps !! 14) :: Maybe Int
            cpu_sy = readMaybe (ps !! 15) :: Maybe Int
            cpu_id = readMaybe (ps !! 16) :: Maybe Int
            cpu_wa = readMaybe (ps !! 17) :: Maybe Int
            cpu_st = readMaybe (ps !! 18) :: Maybe Int

proc' :: String -> [(String, String, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int)]
proc' l = proc'' $ words l

proc :: [String] -> [(String, String, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int)]
proc []     = []
proc (l:ls) = (proc' l) ++ (proc ls)

showResult' (date, time, proc_r, proc_b, mem_swap, mem_free, mem_buff, mem_cache, swap_si, swap_so, io_bi, io_bo, sys_in, sys_cs, cpu_us, cpu_sy, cpu_id, cpu_wa, cpu_st) = "(" ++ date ++ "," ++ time ++ "," ++ show proc_r ++ "," ++ show proc_b ++ "," ++ show mem_swap ++ "," ++ show mem_free ++ "," ++ show mem_buff ++ "," ++ show mem_cache ++ "," ++ show swap_si ++ "," ++ show swap_so ++ "," ++ show io_bi ++ "," ++ show io_bo ++ "," ++ show sys_in ++ "," ++ show sys_cs ++ "," ++ show cpu_us ++ "," ++ show cpu_sy ++ "," ++ show cpu_id ++ "," ++ show cpu_wa ++ "," ++ show cpu_st ++ ")"

showResult :: [(String, String, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int, Int)] -> IO()
showResult [] = return ()
showResult (r:rs) = do
    print $ (showResult' r)
    showResult rs

main :: IO()
main = do
    args <- getArgs 
    ls <- load args
    showResult $ proc ls
    
