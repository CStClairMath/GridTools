import matplotlib.pyplot as plt  #code necessary for the grid diagram printing written by Evan Bell from SURIEM 2021 - saving here in case
import itertools                 #I decide to duplicate the functionality here
from scipy.optimize import curve_fit
from collections import defaultdict
import numpy as np
from numba import jit
from numba import njit
#%matplotlib inline

# Function to create a grid diagram given permutations of X and O positions
def display_grid(x_list, o_list):
    # Getting the size of the grid
    if len(x_list) == len(o_list):
        n = len(x_list)
    else:
        print('The length of the index lists do not match.')
    
    # Initializing figure and making gridlines
    plt.figure(figsize=(10*n/6,10*n/6))
    plt.vlines(range(2,n+1), ymin=1, ymax=n+1, zorder=8, color='gray', linewidth=3)
    plt.hlines(range(2,n+1), xmin=1, xmax=n+1, zorder=10.5, color='gray', linewidth=3)
    
    # Placing the X's and O's
    plt.scatter(np.arange(1, n+1)+0.5, np.array(x_list)+0.5, marker='x', s=1500, linewidth=5, c='black')
    plt.scatter(np.arange(1, n+1)+0.5, np.array(o_list)+0.5, marker='o', s=2000, linewidth=5, c='black')
    plt.scatter(np.arange(1, n+1)+0.5, np.array(o_list)+0.5, marker='o', s=1200, linewidth=5, c='white')

    # Drawing arrows
    for x, y, i in zip(x_list, o_list, range(1, n+1)):
        if x>y: # Downward pointing arrows
            plt.arrow(i+0.5, x+0.25, 0, y-x+.6, width=0.05, head_width=0.2, color='black', length_includes_head=True, zorder=11)
            plt.arrow(i+0.5, x+0.25, 0, y-x+.6, width=0.15, head_width=0.2, color='white', length_includes_head=True, zorder=10)
        if x<y: # Upward pointing arrows
            plt.arrow(i+0.5, x+0.75, 0, y-x-0.6, width=0.05, head_width=0.2, color='black', length_includes_head=True, zorder=11)
            plt.arrow(i+0.5, x+0.75, 0, y-x-0.6, width=0.15, head_width=0.2, color='white', length_includes_head=True, zorder=10)
        if o_list.index(i)<x_list.index(i): # Rightward pointing arrows
            plt.arrow(o_list.index(i)+1.85, i+0.5, x_list.index(i)-o_list.index(i)-0.55, 0, width=0.05, head_width=0.2, color='black', length_includes_head=True, zorder=9)
        if o_list.index(i)>x_list.index(i): # Leftward pointing arrows
            plt.arrow(o_list.index(i)+1.15, i+0.5, x_list.index(i)-o_list.index(i)+0.55, 0, width=0.05, head_width=0.2, color='black', length_includes_head=True, zorder=9)
    
    # Setting up the rest of the plot
    plt.xlim(1, n+1)
    plt.ylim(1, n+1)
    plt.tick_params(axis='x', which='both', bottom=False, labelbottom=False) # https://stackoverflow.com/questions/12998430/remove-xticks-in-a-matplotlib-plot
    plt.tick_params(axis='y', which='both', left=False, labelleft=False)
      