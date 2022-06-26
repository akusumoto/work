#!/usr/bin/env python

import zipfile
import io
from PIL import Image

zip_name = 'ご注文はうさぎですか？ Complete Blend 第01巻.zip'
pdf_name = 'ご注文はうさぎですか？ Complete Blend 第01巻.pdf'
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
		
