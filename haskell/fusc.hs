import Data.Bits

fusc :: Int -> Int
fusc 0 = 0
fusc 1 = 1
fusc n 
    | even n = n1
    | odd n = n2 + n3
    where
        n1 = fusc $ round $ fromIntegral n / 2
        n2 = fusc $ round $ fromIntegral (n-1) / 2
        n3 = fusc $ round $ fromIntegral (n+1) / 2

search [] = []
search (n:ns) = ret ++ search ns
    where
        rev_n = n -- complement n
        ret = if (fusc n) == (fusc rev_n) 
              then [n]
              else []

main = putStrLn $ show $ take 61 $ search [0..]

