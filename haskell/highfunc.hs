
f func n = (func n) * 2
g n = n + 1

ff = f g

main = putStrLn $ show $ ff 3
