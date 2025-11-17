#Implement the 'Exit' function to show a confirmation message before closing theapplication. Assign value from command messagebox.askyesno to variable to confirmeither “Yes” or “No” and exit if got yes.
import tkinter as tk
from tkinter import messagebox
from tkinter import StringVar, BooleanVar

def login():
    user = username_entry.get()
    pwd = password_entry.get()
    global attempts
    attempts = 0
    if attempts >= 3:  
        btn_login.config(state="disabled")
        status_label.config(text="Too many failed attempts. Try again later.")
    else:
        if user == "admin" and pwd == "password":
            messagebox.showinfo("Login Successful", "Welcome!")
            attempts = 0
            status_label.config(text="")
        else:
            attempts += 1
            remaining_attempts = 3 - attempts
            status_label.config(text=f"Login Failed. {remaining_attempts} attempts left.")
            if attempts >= 3:
                btn_login.config(state="disabled")
                status_label.config(text="Too many failed attempts. Try again later.")
                
        
        
def clear():
    username_entry.delete(0, tk.END)
    password_entry.delete(0, tk.END)
    password_entry.config(show="*")
    show_var.set(False)
    btn_login.config(state="normal")
    messagebox.showinfo("Clear", "All fields cleared")
    

def show_help():
    messagebox.showinfo("Help", "Enter your username and password to login. You have 3 attempts.")
    show_var.set(True)
    password_entry.config(show="")
    password_entry.config(show="*")
    show_var.set(False)
    
root = tk.Tk()
root.title("Login Screen")
root.geometry("300x200")

username_label = tk.Label(root, text="Username:")
username_label.grid(row=1, column=0, padx=10, pady=10)
username_entry = tk.Entry(root)
username_entry.grid(row=1, column=1, padx=10, pady=10)
password_label = tk.Label(root, text="Password:")
password_label.grid(row=2, column=0, padx=10, pady=10)
password_entry = tk.Entry(root, show="*")
password_entry.grid(row=2, column=1, padx=10, pady=10)
show_var = BooleanVar()


def show():
    if show_var.get():
        password_entry.config(show="")
    else:
        password_entry.config(show="*")
    login()
    
    
show_label = tk.Label(root, text="Show Password:")
show_label.grid(row=3, column=1, padx=10, pady=10)
show_check = tk.Checkbutton(root, variable=show_var, command=show)
show_check.grid(row=3, column=0, padx=10, pady=10)

help_btn = tk.Button(root, text="Help", command=show_help)
help_btn.grid(row=5, column=1, padx=10, pady=10)

def exit_app():
    if messagebox.askyesno("Exit", "Are you sure you want to exit?"):
        root.destroy()
        attempts = 0
        btn_login.config(state="normal")
        


status_label = tk.Label(root, text="")
status_label.grid(row=3, column=0, padx=10, pady=10)
btn_login = tk.Button(root, text="Login", command=show)
btn_login.grid(row=4, column=0, padx=10, pady=10)
btn_clear = tk.Button(root, text="Clear", command=clear)
btn_clear.grid(row=4, column=1, padx=10, pady=10)
btn_exit = tk.Button(root, text="Exit", command=exit_app)
btn_exit.grid(row=4, column=2, padx=10, pady=10)
btn_login.config(state="normal")




def on_enter_key(event):
    show()
btn_exit.grid(row=4, column=2, padx=10, pady=10)
help_btn = tk.Button(root, text="Help", command=show_help)

help_btn.grid(row=5, column=1, padx=10, pady=10)
root.bind('<Return>', on_enter_key)




root.mainloop()
