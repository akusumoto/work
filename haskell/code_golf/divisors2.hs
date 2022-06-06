g _ 0="" 
g n d=g n(d-1)++s where s=if mod n d==0 then show d++" "else""
f 1="1"
f n=f(n-1)++"\n"++g n n 
main=putStr$f 100
