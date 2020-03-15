f x = x + 1
g x = x * 2

main = do
    putStrLn $ "g(f(5)) = " ++ (show $ f(g(5)))
    putStrLn $ "(g.f)(5) =" ++ (show $ (g.f)(5)) 
    putStrLn $ "(f.g)(5) =" ++ (show $ (f.g)(5)) 
