#!/usr/bin/env python

import os
print("os.getcwd() =", os.getcwd())
print("__file__    =", __file__)

import tempfile
with tempfile.TemporaryDirectory() as d:
	print("tempfile.TemporaryDirectory() =", d)
	with open(os.path.join(d, "test.txt"), "w") as f:
		print("test", file=f)
# the directory 'd' and the files in 'd' are deleted here 


