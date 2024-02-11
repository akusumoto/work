import matplotlib.pyplot as plt
import matplotlib.patches as pch

#fig = plt.figure()
ax = plt.axes()

c = pch.Circle(xy=(0, 0), radius=0.5, fc='g', ec='r')
ax.add_patch(c)

plt.axis('scaled')
ax.set_aspect('equal')

plt.show()