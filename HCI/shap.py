from vpython import *
# Create a 3D scene
scene.title = "3D Transformations in Graphics Programming"
scene.background = color.white
# Create a cube
cube = box(pos=vector(0, 0, 0), size=vector(1, 1, 1), color=color.blue)
label(pos=vector(0, 1.5, 0), text='Original Cube', height=15, box=False, color=color.black)
# Translation (move along X-axis)
cube_translated = box(pos=vector(2, 0, 0), size=vector(1, 1, 1), color=color.red)
label(pos=vector(2, 1.5, 0), text='Translated Cube', height=15, box=False, color=color.black)
# Scaling (resize)
cube_scaled = box(pos=vector(-2, 0, 0), size=vector(1.5, 0.5, 1), color=color.green)
label(pos=vector(-2, 1.5, 0), text='Scaled Cube', height=15, box=False, color=color.black)
# Rotation (around Y-axis)
cube_rotated = box(pos=vector(4, 0, 0), size=vector(1, 1, 1), color=color.purple)
cube_rotated.rotate(angle=radians(45), axis=vector(0, 1, 0))

label(pos=vector(4, 1.5, 0), text='Rotated Cube', height=15, box=False, color=color.black)
# Add lighting (for visual effect)
distant_light(direction=vector(1, 1, 1), color=color.white)