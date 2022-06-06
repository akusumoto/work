s n | n == 1 = "1 bottle"
    | otherwise = show n ++ " bottles"
p 0 = putStrLn "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall."
p 1 = do
    putStrLn "1 bottle of beer on the wall, 1 bottle of beer.\nTake one down and pass it around, no more bottles of beer on the wall.\n"
    p 0 
p n = do
    putStrLn $ b ++ " of beer on the wall, " ++ b ++ " of beer.\nTake one down and pass it around, " ++ c ++ " of beer on the wall.\n"
    p (n-1)
    where b = s n
          c = s (n-1)

main = p 99
