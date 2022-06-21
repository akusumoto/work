#!/usr/bin/env python3

import tkinter as tk
import os

def func_ok():
	print("OK")

def clear_ent(ent):
	ent.delete(0, tk.END)
	print("Cleared")

def clear_txt(txt):
	txt.delete("1.0", tk.END)
	print("Cleared")

def func_txt(txt):
	txt.insert(tk.END, "INSERTED!!\n")

win = None
def open_new_window():
	global win
	if win == None:
		win = tk.Toplevel(window)
		win.title("New Window")

base_dir = os.path.dirname(__file__)

current_picture_name = ''
def change_picture(canvas, cvid):
	global current_picture_name, img

	if current_picture_name == 'pic/pc1.png':
		current_picture_name = 'pic/pc2.png'
	elif current_picture_name == 'pic/pc2.png':
		current_picture_name = 'pic/pc1.png'
	print('change picture -> ' + current_picture_name)

	img = tk.PhotoImage(file=os.path.join(base_dir, current_picture_name))
	img = img.subsample(5) # 512 / 5 -> 100?

	canvas.itemconfig(cvid, image=img)

	
	
window = tk.Tk()
window.title("Hello World")
window.geometry("400x800")

menu = tk.Menu(window)

mnu_file = tk.Menu(menu, tearoff=0)
menu.add_cascade(label="File", menu=mnu_file)
mnu_file.add_command(label="Open")
mnu_file.add_command(label="Exit", command=window.destroy)	

window.config(menu=menu)


frm_header = tk.Frame(master=window)

label = tk.Label(master=frm_header, text="Sample")
label.pack()

frm_header.pack()


frm_frame1 = tk.Frame(master=window)

ent = tk.Entry(master=frm_frame1)
ent.pack()

btn_clear = tk.Button(master=frm_frame1, text="Clear", command=lambda e=ent: clear_ent(e))
btn_clear.pack()

frm_frame1.pack()


frm_frame2 = tk.Frame(master=window)

txt = tk.Text(master=frm_frame2, height=20)
txt.pack()


frm_frame2_btns = tk.Frame(master=frm_frame2, height=10)

btn_insert = tk.Button(master=frm_frame2_btns, text="Insert", command=lambda e=txt: func_txt(e))
btn_insert.pack(fill=tk.Y, side=tk.LEFT)

btn_clear = tk.Button(master=frm_frame2_btns, text="Clear", command=lambda e=txt: clear_txt(e))
btn_clear.pack(fill=tk.Y, side=tk.LEFT)

btn_ok = tk.Button(master=frm_frame2_btns, text="OK", command=window.destroy)
#btn_ok = tk.Button(text="OK", command=func_ok)
btn_ok.pack(fill=tk.Y, side=tk.LEFT)

frm_frame2_btns.pack()
frm_frame2.pack(fill=tk.Y)

frm_frame3 = tk.Frame(master=window)
btn_popup = tk.Button(master=frm_frame3, text="Popup", command=open_new_window)
btn_popup.pack()
frm_frame3.pack(fill=tk.Y)


frm_frame4 = tk.Frame(master=window)
canvas = tk.Canvas(master=frm_frame4)
current_picture_name = 'pic/pc1.png'
img = tk.PhotoImage(file=os.path.join(base_dir, current_picture_name))
img = img.subsample(5) # 512 / 5 -> 100?
cvid = canvas.create_image(0, 0, image=img, anchor=tk.NW)
canvas.pack()

btn_change = tk.Button(master=frm_frame4, text='Change', command=lambda c=canvas, cvid=cvid: change_picture(c, cvid))
btn_change.pack()
frm_frame4.pack(fill=tk.Y)

window.mainloop()
