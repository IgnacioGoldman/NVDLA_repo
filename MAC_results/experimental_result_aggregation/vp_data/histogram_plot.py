import matplotlib.pyplot as plt
import numpy as np
import matplotlib
import sys

f= np.loadtxt("MNIST_plot_data/inference_INT8_histogram.txt", unpack='False')

#bins = np.linspace(0, 10000000000, 100000)
bins = 30

name = "fig_inference_INT8_histogram.png"

plt.hist(f, bins, range=[-1000000, 1000000])
plt.xlabel('absolute error')
plt.ylabel('n')
plt.savefig(str(name))

