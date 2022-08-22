from turtle import color
from mayavi import mlab

t = []
x = []
y = []
z = []

px = []
py = []
pz = []
with open("model1.csv", "r") as file:
    for line in file:
        tokens = line.split(",")
        pos = float(tokens[0])
        t.append(pos)  
        x.append(float(tokens[1]))  
        y.append(float(tokens[2]))  
        z.append(float(tokens[3]))  

        if pos.is_integer():
            px.append(float(tokens[1]))  
            py.append(float(tokens[2]))  
            pz.append(float(tokens[3]))  


mlab.figure(bgcolor=(0.0, 0.0, 0.0), size=(1600, 1200))
mlab.plot3d(x, y, z, tube_radius=0.12)
mlab.points3d(px, py, pz, scale_factor=0.5, color=(1.0, 0.0, 0.0))
mlab.show()
