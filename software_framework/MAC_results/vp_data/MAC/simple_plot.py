import matplotlib.pyplot as plt
import csv
import sys

x = []
y = []
name = []

with open("MNIST_plot_data/approx_reduced_INT8_plot.txt",'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x.append(int(row[0]))
        y.append(float(row[1]))

name = "fig_inference_INT8_plot.png"

plt.scatter(x,y)
# set axes range
plt.ylim(0, 35)
plt.xlim(-150000000, 150000000)
plt.xlabel('exact MAC result')
plt.ylabel('error')
plt.savefig(str(name))   # save the figure to file
#plt.show()


