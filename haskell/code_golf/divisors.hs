g _ 0 = "" 
g n d 
    | mod n d == 0 = g n (d-1) ++ show d ++ " "
    | otherwise    = g n (d-1)

f 1 = "1"
f n = f (n-1) ++ "\n" ++ g n n 

main = putStrLn $ f 100
