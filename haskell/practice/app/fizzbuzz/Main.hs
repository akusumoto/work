module Main where

g 0 0 x="fizzbuzz"
g 0 _ x="fizz"
g _ 0 x="buzz"
g _ _ x=show x
f[]=""
f(x:y)=g(mod x 3)(mod x 5)x++"\n"++f y

main :: IO()
main = putStr$f[1..100]
