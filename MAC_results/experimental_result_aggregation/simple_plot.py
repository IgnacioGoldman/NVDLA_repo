import matplotlib.pyplot as plt
import csv
import sys

x = []
y = []
name = []

with open(str(sys.argv[1]),'r') as csvfile:
    plots = csv.reader(csvfile, delimiter=',')
    for row in plots:
        x.append(int(row[0]))
        y.append(float(row[1]))

array = str(sys.argv[1]).split("/")
name = "fig_"+array[1][0:-4]+".png"

plt.scatter(x,y)
plt.xlabel('exact multiplication result')
plt.ylabel('error')
plt.savefig(str(name))   # save the figure to file
#plt.show()


