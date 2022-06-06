a="bottle"
s n
 |n<0="99 bottles"
 |n==0="no more bottles"
 |n==1="1 bottle"
 |otherwise=show n++" bottles"
p n=b++" of beer on the wall, "++b++" of beer.\n"++d++c++" of beer on the wall.\n\n"++t
 where
  b=s n
  c=s(n-1)
  d=case n of 0->"Go to the store and buy some more, "
              _->"Take one down and pass it around, "
  t=case n of 0->""
              _->p(n-1)
main=putStr$p 99
