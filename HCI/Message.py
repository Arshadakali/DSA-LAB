import tkinter as tk
from tkinter import messagebox

def on_login():
    username = entry_user.get().strip()
    password = entry_pwd.get()
    
    # Input validation
    if not username or not password:
        messagebox.showwarning("Input Error", "Please enter both username and password")
        return
    
    print("Username:", username)
    print("Password:", password)
    # Here you would typically add authentication logic

def on_enter_key(event):
    on_login()

# Create main window
root = tk.Tk()
root.title("Login Screen")
root.geometry("300x200")

# Wireframe elements 
title = tk.Label(root, text="Login Screen", font=("Arial", 14, "bold"))
title.pack(pady=15)

# Username
tk.Label(root, text="Username:").pack(anchor="w", padx=50)
entry_user = tk.Entry(root, width=25)
entry_user.pack(pady=2)
entry_user.focus()  # Set initial focus

# Password
tk.Label(root, text="Password:").pack(anchor="w", padx=50)
entry_pwd = tk.Entry(root, show="*", width=25)
entry_pwd.pack(pady=2)

# Bind Enter key to login
entry_pwd.bind('<Return>', on_enter_key)

# Buttons row (use a frame to group both buttons)
btn_frame = tk.Frame(root)
btn_frame.pack(pady=15)

# Add Login button
login_btn = tk.Button(btn_frame, text="Login", command=on_login, width=8)
login_btn.pack(side="left", padx=10)

# Add Exit button (in same frame for consistent layout)
quit_btn = tk.Button(btn_frame, text="Exit", command=root.destroy, width=8)
quit_btn.pack(side="left", padx=10)

root.mainloop()