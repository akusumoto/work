#!/usr/bin/env python
# -*- coding:utf-8 -*-

from fileinput import filename
import zipfile
import io
from PIL import Image
import sys
import os

try:
	zip_name = sys.argv[1]
except:
	print("usage: zip2pdf.py (zip file name)")
	sys.exit(1)
if zip_name.endswith(".zip") is False:
	print(f"not zip file: {zip_name}")
	sys.exit(2)

base_name = os.path.splitext(os.path.basename(zip_name))[0]
dir_name = os.path.dirname(zip_name)
pdf_name = os.path.join(dir_name, base_name + ".pdf")
print(f"zip: {zip_name}")
print(f"pdf: {pdf_name}")

with zipfile.ZipFile(zip_name) as z:
	#z.printdir()	
	pdf = None
	imgs = []
	page = 1
	file_list = z.namelist()
	file_list.sort()
	n_pages = len(file_list)
	for f in file_list:
		print(f'loading [{page}/{n_pages}] {f} ... ', end='', flush=True)
		print("ok")
		page += 1
		continue
		with z.open(f) as img_file:
			img_bin = io.BytesIO(img_file.read())
			img = Image.open(img_bin)
			if pdf:
				imgs.append(img)
			else:
				pdf = img.convert('RGB')
			print('ok')
		page += 1
	print("saving pdf ... ", end='', flush=True)
	pdf.save(pdf_name, save_all=True, append_images=imgs)
	print('ok')

print("done")
		
