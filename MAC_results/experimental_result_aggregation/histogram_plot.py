import matplotlib.pyplot as plt
import numpy as np
import matplotlib
import sys

f= np.loadtxt(str(sys.argv[1]), unpack='False')

#bins = np.linspace(0, 10000000000, 100000)
bins = 30

array = str(sys.argv[1]).split("/")
name = "fig_"+array[1][0:-4]+".png"

plt.hist(f, bins)
plt.xlabel('absolute error')
plt.ylabel('n')
plt.savefig(str(name))

