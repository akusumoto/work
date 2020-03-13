# https://rosettacode.org/wiki/4-rings_or_4-squares_puzzle
def c(a,z):
 if len(a)>0:for n in a:c([j for j in a if j!=n],z+[n])
 else:if sum(z[:2])==sum(z[1:4])==sum(z[3:6])==sum(z[5:]):print z
c([i for i in range(1,8)],[])
