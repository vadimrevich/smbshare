#!python
import tkinter as tk

root = tk.Tk()
root.overrideredirect(True)
root.geometry("+10+10")
label = tk.Label(root, text="Активировать Windows", bg='white', fg='black')
label.pack(padx=5, pady=5)
root.mainloop()
