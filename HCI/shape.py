import tkinter as tk


root = tk.Tk()
root.title("Traffic Light Simulation")
root.geometry("300x500")


canvas = tk.Canvas(root, width=300, height=400, bg='white')
canvas.pack(pady=20)


box = canvas.create_rectangle(100, 50, 200,550, outline="black", width=2, fill='white')

# Calculate positions for perfectly centered and evenly spaced lights
light_width = 60
light_spacing = 35
box_top = 70

red_light = canvas.create_oval(120, box_top, 120+light_width, box_top+light_width, fill='red')
yellow_light = canvas.create_oval(120, box_top+light_width+light_spacing, 120+light_width, box_top+2*light_width+light_spacing, fill='gray')
green_light = canvas.create_oval(120, box_top+2*light_width+2*light_spacing, 120+light_width, box_top+3*light_width+2*light_spacing, fill='gray')
gray_light = canvas.create_oval(120, box_top+3*light_width+3*light_spacing, 120+light_width,box_top+4*light_width+3*light_spacing, fill='gray')

def red_on():
    canvas.itemconfig(red_light, fill='red')
    canvas.itemconfig(yellow_light, fill='gray')
    canvas.itemconfig(green_light, fill='gray')
    canvas.itemconfig(gray_light, fill='gray')
def yellow_on():
    canvas.itemconfig(red_light, fill='gray')
    canvas.itemconfig(yellow_light, fill='yellow')
    canvas.itemconfig(green_light, fill='gray')
    canvas.itemconfig(gray_light, fill='gray')

def green_on():
    canvas.itemconfig(red_light, fill='gray')
    canvas.itemconfig(yellow_light, fill='gray')
    canvas.itemconfig(green_light, fill='green')
    canvas.itemconfig(gray_light, fill='gray')
    
def gray_on():
    canvas.itemconfig(red_light, fill='white')
    canvas.itemconfig(yellow_light, fill='white')
    canvas.itemconfig(green_light, fill='white')
    canvas.itemconfig(gray_light, fill='gray')



button_frame = tk.Frame(root)
button_frame.pack(pady=20)

tk.Button(button_frame, text="Red", command=red_on, 
         bg='red', fg='white', width=8).pack(side=tk.LEFT, padx=5)
tk.Button(button_frame, text="Yellow", command=yellow_on,
         bg='yellow', fg='black', width=8).pack(side=tk.LEFT, padx=5)
tk.Button(button_frame, text="Green", command=green_on,
         bg='green', fg='white', width=8).pack(side=tk.LEFT, padx=5)
tk.Button(button_frame, text="gray", command=gray_on,
         bg='green', fg='white', width=8).pack(side=tk.LEFT, padx=5)

root.mainloop()
