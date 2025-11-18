#message box create
import tkinter as tk
from tkinter import messagebox

def show():
    user = username_entry.get()
    pwd = password_entry.get()
    if not user or not pwd:
        messagebox.showerror("error", "invalid input")
    else:
        messagebox.showinfo("sucess","password sucess")
        
def clear():
    username_entry.delete(0,tk.END)
    password_entry.delete(0,tk.END)
    
def exit_app():
    root.destroy()

root =tk.Tk()
root.title("Login Screen")
root.geometry("300x200")

username_label = tk.Label(root, text="username")
username_label.pack
username_entry = tk.Entry(root)
username_entry.pack
password_label = tk.Label(root, text="password")    
password_label.pack
password_entry =tk.Entry(root)
password_entry.pack

login_button =tk.Button(root, text="login", command=show)
login_button.pack(side=tk.LEFT,padx=15,pady=10)
clear_button =tk.Button(root, text="login", command=clear)
clear_button.pack(side=tk.LEFT,padx=15,pady=10)
exit_button =tk.Button(root, text="login", command=exit)
exit_button.pack(side=tk.LEFT,padx=15,pady=10)
root.mainloop()
