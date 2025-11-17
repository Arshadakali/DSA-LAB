import tkinter as tk
 
# Create main window
root = tk.Tk()
root.title("Lab 3: Drawing Basic Shapes, Colors, and Transformations in 2D")


canvas = tk.Canvas(root, width=400, height=400, bg="white")
canvas.pack() 


rect = canvas.create_rectangle(50, 50, 150, 150, fill="lightblue")
circle = canvas.create_oval(200, 50, 300, 150, fill="lightgreen")
triangle = canvas.create_polygon(100, 200, 50, 300, 150, 300, fill="pink")

# Define color change functions
def set_red():
    canvas.itemconfig(rect, fill="red")
    canvas.itemconfig(circle, fill="red")
    canvas.itemconfig(triangle, fill="red")

def set_blue():
    canvas.itemconfig(rect, fill="blue")
    canvas.itemconfig(circle, fill="blue")
    canvas.itemconfig(triangle, fill="blue")

def set_green():
    canvas.itemconfig(rect, fill="green")
    canvas.itemconfig(circle, fill="green")
    canvas.itemconfig(triangle, fill="green")

# Buttons row (use a frame to group)
btn_frame = tk.Frame(root)
btn_frame.pack(pady=10)

# Buttons
btn_red = tk.Button(btn_frame, text="Red", width=8, command=set_red)
btn_red.pack(side=tk.LEFT, padx=10)
btn_blue = tk.Button(btn_frame, text="Blue", width=8, command=set_blue)
btn_blue.pack(side=tk.LEFT, padx=10)
btn_green = tk.Button(btn_frame, text="Green", width=8, command=set_green)
btn_green.pack(side=tk.LEFT, padx=10)

# Exit button
tk.Button(root, text="Exit", command=root.destroy).pack(pady=10)

# Run the application
root.mainloop()