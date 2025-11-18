
import tkinter as tk
from tkinter import messagebox

def show():
    user = username_entry.get()
    pwd = password_entry.get()
    if user == "" or pwd == "":
        messagebox.showerror("Error", "Invalid Input")
    else:
        messagebox.showinfo("Success", "Login Successful")
    username_entry.delete(0, tk.END)
    password_entry.delete(0, tk.END)

def clear():
    username_entry.delete(0, tk.END)
    password_entry.delete(0, tk.END)

def exit_app():
    root.destroy()

root = tk.Tk()
root.title("Login Screen")
root.geometry("300x200")

username_label = tk.Label(root, text="Username:")
username_label.pack()
username_entry = tk.Entry(root)
username_entry.pack()
password_label = tk.Label(root, text="Password:")
password_label.pack()
password_entry = tk.Entry(root, show="*")
password_entry.pack()

login_button = tk.Button(root, text="Login", command=show)
login_button.pack(side=tk.LEFT, padx=15, pady=10)
clear_button = tk.Button(root, text="Clear", command=clear)
clear_button.pack(side=tk.LEFT, padx=30, pady=10)
exit_button = tk.Button(root, text="Exit", command=exit_app)
exit_button.pack(side=tk.LEFT, padx=50, pady=10)
root.mainloop()