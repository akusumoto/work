#!/usr/bin/env python

class Samp:
    def __init__(self, name = '(no name)'):
        self.__name = name
    
    @property
    def name(self):
        return self.__name

    @name.setter
    def name(self, name):
        self.__name = name

s = Samp()
print(f"{s.name}")

s2 = Samp("aaa")
print(f"{s2.name}")

s2.name = "bbb"
print(f"{s2.name}")

s2.name = 10
print(f"{s2.name}")
