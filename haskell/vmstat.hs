module Main where

-- vmstat.log 
-- 2020-02-25 00:00:25 procs -----------memory---------- ---swap-- -----io---- --system-- -----cpu-----
-- 2020-02-25 00:00:25  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id  wa st 
-- 2020-02-25 00:00:25  0  0 1401944 185212 130404 490940    0    0     0     0  168  328  1  0 100  0  0  -- 2020-02-25 00:00:26  0  0 1401944 185212 130404 490940    0    0     0     0  176  325  0  0 99   0  0   
-- 1          2         3  4 5       6      7      8         9   10    11    12   13   14 15 16 17  18 19

import System.Environment (getArgs)
import System.IO
import Text.Read (readMaybe)

data Stat = Stat { date :: String, time :: String, 
                   proc_r :: Int, proc_b :: Int, 
                   mem_swap :: Int, mem_free :: Int, mem_buff :: Int, mem_cache :: Int, 
                   swap_si :: Int, swap_so :: Int, 
                   io_bi :: Int, io_bo :: Int, 
                   sys_in :: Int, sys_cs :: Int, 
                   cpu_us :: Int, cpu_sy :: Int, cpu_id :: Int, cpu_wa :: Int, cpu_st :: Int 
                } deriving Show

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

justStat :: String -> String -> Maybe Int
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
                            -> [Stat]
justStat date time (Just proc_r) (Just proc_b)
                  (Just mem_swap) (Just mem_free) (Just mem_buff) (Just mem_cache) 
                  (Just swap_si) (Just swap_so) 
                  (Just io_bi) (Just io_bo) 
                  (Just sys_in) (Just sys_cs) 
                  (Just cpu_us) (Just cpu_sy) (Just cpu_id) (Just cpu_wa) (Just cpu_st) 
        = [Stat date time 
                proc_r proc_b 
                mem_swap mem_free mem_buff mem_cache 
                swap_si swap_so 
                io_bi io_bo 
                sys_in sys_cs 
                cpu_us cpu_sy cpu_id cpu_wa cpu_st]
justStat date time _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ = []



proc'' :: [String] -> [Stat]
proc'' ps 
    | length ps == 19 = justStat date time
                                proc_r proc_b
                                mem_swap mem_free mem_buff mem_cache
                                swap_si swap_so
                                io_bi io_bo
                                sys_in sys_cs
                                cpu_us cpu_sy cpu_id cpu_wa cpu_st
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

proc' :: String -> [Stat]
proc' l = proc'' $ words l

proc :: [String] -> [Stat]
proc []     = []
proc (l:ls) = (proc' l) ++ (proc ls)

showResult' :: Stat -> String
showResult' stat =        (date stat) ++ " "
                       ++ (time stat) ++ "," 
                       ++ (show $ proc_r stat) ++ "," 
                       ++ (show $ proc_b stat) ++ "," 
                       ++ (show $ mem_swap stat) ++ "," 
                       ++ (show $ mem_free stat) ++ "," 
                       ++ (show $ mem_buff stat) ++ ","
                       ++ (show $ mem_cache stat) ++ "," 
                       ++ (show $ swap_si stat) ++ "," 
                       ++ (show $ swap_so stat) ++ "," 
                       ++ (show $ io_bi stat) ++ "," 
                       ++ (show $ io_bo stat) ++ "," 
                       ++ (show $ sys_in stat) ++ "," 
                       ++ (show $ sys_cs stat) ++ ","
                       ++ (show $ cpu_us stat) ++ "," 
                       ++ (show $ cpu_sy stat) ++ "," 
                       ++ (show $ cpu_id stat) ++ "," 
                       ++ (show $ cpu_wa stat) ++ "," 
                       ++ (show $ cpu_st stat) 

showResult :: [Stat] -> IO()
showResult [] = return ()
showResult (r:rs) = do
    putStrLn $ (showResult' r)
    showResult rs

foldStat :: (Int -> Stat -> Int) -> Int -> [Stat] -> Int
foldStat func sum [] = sum
foldStat func sum (stat:stats) = foldStat func ret stats
    where 
        ret = func sum stat

sumStat' :: (Stat -> Int) -> Int -> [Stat] -> Int
sumStat' vfunc sum [] = sum
sumStat' vfunc sum (stat:stats) = sumStat' vfunc (sum + vfunc stat) stats

sumStat :: (Stat -> Int) -> [Stat] -> Int
sumStat vfunc stats = sumStat' vfunc 0 stats

aveStat' :: (Stat -> Int) -> Int -> Int -> [Stat] -> Int
aveStat' vfunc sum n [] = truncate ((fromIntegral sum) / (fromIntegral n))
aveStat' vfunc sum n (stat:stats) = aveStat' vfunc (sum + vfunc stat) (n+1) stats

aveStat :: (Stat -> Int) -> [Stat] -> Int
aveStat vfunc stats = aveStat' vfunc 0 0 stats

summarize' :: [Stat] -> [Stat] -> [Stat] -> [Stat]
summarize' [] _ sum_stats = sum_stats
summarize' (stat:stats) tmp_stats sum_stats
    | length tmp_stats < 60 = summarize' stats (tmp_stats ++ [stat]) sum_stats
    | length tmp_stats > 60 = summarize' (stat:stats) (tail tmp_stats) sum_stats
    | otherwise = summarize' stats [] (sum_stats ++ [sum_stat])
        where
            s_date = date (tmp_stats !! 0) 
            s_time = time (tmp_stats !! 0) 
            s_proc_r = sumStat proc_r tmp_stats
            s_proc_b = sumStat proc_b tmp_stats
            s_mem_swap = aveStat mem_swap tmp_stats
            s_mem_free = aveStat mem_free tmp_stats
            s_mem_buff = aveStat mem_buff tmp_stats
            s_mem_cache = aveStat mem_cache tmp_stats
            s_io_bi = sumStat io_bi tmp_stats
            s_io_bo = sumStat io_bo tmp_stats
            s_swap_si = aveStat swap_si tmp_stats
            s_swap_so = aveStat swap_so tmp_stats
            s_sys_in = sumStat sys_in tmp_stats
            s_sys_cs = sumStat sys_cs tmp_stats 
            s_cpu_us = aveStat cpu_us tmp_stats
            s_cpu_sy = aveStat cpu_sy tmp_stats
            s_cpu_id = aveStat cpu_id tmp_stats
            s_cpu_wa = aveStat cpu_wa tmp_stats
            s_cpu_st = aveStat cpu_st tmp_stats
            sum_stat = Stat s_date s_time
                            s_proc_r s_proc_b
                            s_mem_swap s_mem_free s_mem_buff s_mem_cache
                            s_swap_si s_swap_so
                            s_io_bi s_io_bo
                            s_sys_in s_sys_cs
                            s_cpu_us s_cpu_sy s_cpu_id s_cpu_wa s_cpu_st


summarize :: [Stat] -> [Stat]
summarize stats = summarize' stats [] [] 

main :: IO()
main = do
    args <- getArgs 
    ls <- load args
    showResult $ summarize $ proc ls
    
