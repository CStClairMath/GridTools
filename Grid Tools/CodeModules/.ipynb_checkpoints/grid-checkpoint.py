#Settings:

QUIET = True #Just here so you can tell a function "QUIET" or "INVIS" and for some of these it will suppress part 
INVIS = False #of the output. For INVIS this will be graphical outputs
FORCE_VALID_GRIDS = False #Not fully implemented - may let some X and O be placed in the same square
FORCE_VALID_MOVES = False #Not fully implemented - prevents stabilizing where we can't and commuting columns illegally


from .perm import *
import math
import sys
import copy

STAB_DIRS = ["NE","NW","SW","SE"]

class grid:      #Carries knot data - functions asking for a knot (unless otherwise specified)  
                 #are asking for a grid
        
    def __init__(self, given_x, given_o, check_grid_conditions = FORCE_VALID_GRIDS): #Loads grid information into the object and confirms the grid size is square
        check_if_valid(given_x)
        check_if_valid(given_o)
        self.sig_x = perm(given_x)
        self.sig_o = perm(given_o)
        self.size = perm(given_x).size()
        if self.size != perm(given_o).size():
            raise ValueError("Grid dimensions are not equal to eachother")
        if check_grid_conditions:
            for i in self.size:
                if self.sig_x.value[i] == self.sig_o.value[i]:
                    raise ValueError("Invalid grid - X and O appear in the same square")
                
    def __repr__(self, hide=INVIS):
        if not QUIET:
            print("sig_x: " + str(self.sig_x))
            print("sig_o: " + str(self.sig_o))
        if not hide:
            display_grid(self.sig_x.value, self.sig_o.value)
        return str([self.sig_x,self.sig_o])

    def show(self):
        display_grid(self.sig_x.value, self.sig_o.value)
        return
    
    def __str__(self):
        return (str(self.sig_x)+str(self.sig_o))
    
    def h_cycle(self, n = 1): #cycles the grid as a toroidal diagram horizontally n (negative to the left) times
        cycler = full_cycle(self.size)
        print(cycler)
        new_sig_x = self.sig_x*((cycler)**n)
        new_sig_o = self.sig_o*((cycler)**n)
        return grid(new_sig_x, new_sig_o)
    
    def v_cycle(self, n = 1): #cycles the grid as a toroidal diagram vertically n (negative down) times
        cycler = full_cycle(n)
        new_sig_x = ((cycler)**n)*self.sig_x
        new_sig_o = ((cycler)**n)*self.sig_o
        return grid(new_sig_x, new_sig_o)
        
    def x_stab(self, x_choice, direction = "NW"): #grid stabilization at an x - essentially splits that x into two rows and columns
                                                  #this makes for 4 (valid) ways to fill in the gaps, NW,NE,SE,SW
        h_switch = perm_from_cycle(((x_choice, x_choice+1),), self.size+1)
        v_switch = perm_from_cycle(((self.sig_x[x_choice],self.sig_x[(x_choice)]+1),), self.size+1)
        temp_sig_x = self.sig_x.widen_at(x_choice, self.sig_x[(x_choice)])
        temp_sig_o = self.sig_o.widen_at(x_choice, self.sig_x[(x_choice)])
        if direction == "NW":
            temp_sig_o = temp_sig_o*h_switch
            return grid(temp_sig_x,temp_sig_o)
        if direction == "NE":
            temp_sig_x = temp_sig_x*h_switch
            return grid(temp_sig_x,temp_sig_o)
        if direction == "SE":
            temp_sig_x = temp_sig_x
            temp_sig_o = v_switch*temp_sig_o
            return grid(temp_sig_x,temp_sig_o)
        if direction == "SW":
            temp_sig_x = temp_sig_x*h_switch
            temp_sig_o = v_switch*(temp_sig_o*h_switch)
            return grid(temp_sig_x,temp_sig_o)

    def x_destab(self, x_choice, check_if_legal = FORCE_VALID_MOVES): #still need to work out how to check for legality - ie see if the place
        height = self.sig_x[x_choice]                                 #we destabilize at is one of NE NW SE SW.
        x_temp = self.sig_x.collapse_at(x_choice)
        helper = perm_from_cycle(((height,self.sig_o[x_choice]),),self.size)
        o_temp = self.sig_o
        o_temp = (helper*o_temp).collapse_at(x_choice)
        return grid(x_temp, o_temp)

    def __hash__(self):
        identifier = ''
        for x in self.sig_x:
            identifier = identifier + str(x)
        for o in self.sig_o:
            identifier = identifier + str(o)
        return int(identifier)    
    
    
    def commute_columns(self, left_position, ValidGridMove = FORCE_VALID_MOVES):
        h_switch = perm_from_cycle(((left_position, left_position+1),), self.size)
        new_sig_x = self.sig_x*h_switch
        new_sig_o = self.sig_o*h_switch
        return grid(new_sig_x, new_sig_o)
        
    def __eq__(self, other):
        if type(other) != grid:
            return False
        if self.sig_x == other.sig_x:
            if self.sig_o == other.sig_o:
                return True
        return False

#END OF GRID TYPE DEFINITION    
    
    
def generate_all_grids(n):     #this is (as far as I can tell) tied to derangements, which is an NP-complete problem so this won't be
    perm_set = generate_sn(n)  #able to be incredibly optimized
    hold = []
    for element in perm_set:
        for other in perm_set:
            sudokurule = True
            for i in range(n):
                if element[i+1] == other[i+1]:
                    sudokurule = False
                    break
            if sudokurule:
                hold.append(grid(element,other))
    return hold

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
      