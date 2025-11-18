import tkinter as tk
from tkinter import messagebox

def login():
    user = username_var.get().strip()
    pwd = password_var.get().strip()
    if not user or not pwd:
        messagebox.showerror("Error", "Please enter username and password.")
        return
    messagebox.showinfo("Success", "Login Successful")
    clear()

def clear():
    username_var.set("")
    password_var.set("")

def exit_app():
    root.destroy()

def toggle_password():
    if show_password_var.get():
        password_entry.config(show="")
    else:
        password_entry.config(show="*")

root = tk.Tk()
root.title("Login")
root.geometry("320x180")
root.resizable(False, False)

username_var = tk.StringVar()
password_var = tk.StringVar()
show_password_var = tk.BooleanVar(value=False)

tk.Label(root, text="Username").grid(row=0, column=0, padx=10, pady=(12, 6), sticky="e")
username_entry = tk.Entry(root, textvariable=username_var, width=24)
username_entry.grid(row=0, column=1, padx=10, pady=(12, 6), sticky="w")

tk.Label(root, text="Password").grid(row=1, column=0, padx=10, pady=6, sticky="e")
password_entry = tk.Entry(root, textvariable=password_var, show="*", width=24)
password_entry.grid(row=1, column=1, padx=10, pady=6, sticky="w")

show_cb = tk.Checkbutton(root, text="Show password", variable=show_password_var, command=toggle_password)
show_cb.grid(row=2, column=1, padx=10, pady=6, sticky="w")

btn_frame = tk.Frame(root)
btn_frame.grid(row=3, column=0, columnspan=2, pady=12)

tk.Button(btn_frame, text="Login", width=10, command=login).pack(side=tk.LEFT, padx=6)
tk.Button(btn_frame, text="Clear", width=10, command=clear).pack(side=tk.LEFT, padx=6)
tk.Button(btn_frame, text="Exit", width=10, command=exit_app).pack(side=tk.LEFT, padx=6)

root.bind("<Return>", lambda e: login())
username_entry.focus()

root.mainloop()