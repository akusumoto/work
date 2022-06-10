#!/usr/bin/env python3

import tkinter as tk

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
	
window = tk.Tk()
window.title("Hello World")
window.geometry("400x400")

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

window.mainloop()
