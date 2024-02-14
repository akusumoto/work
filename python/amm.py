#!/usr/bin/env python

import pyautogui
import time
import datetime

m = [100,0,-100,0]
xi = 0
yi = 3
start = time.time()
try:
	while True:
		pyautogui.move(m[xi],m[yi])
		print(f"{datetime.datetime.now()} - move ({m[xi]},{m[yi]}) -> ({pyautogui.position().x},{pyautogui.position().y})")

		xi = (xi + 1) % len(m)
		yi = (yi + 1) % len(m)
		time.sleep(10)
except KeyboardInterrupt:
	print("canceled")
