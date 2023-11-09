import sys
import pickle
import time
from .perm import *
import networkx as nx


#######################################################################################
#First chunk is code for actually computing the complex
#######################################################################################

def is_between(target, a, b):
    
    #Input: integers target, a, b
    #
    #Output: Returns True if target is between a and b False otherwise
    
    if target > a:
        if target < b:
            return True
    return False

#Note: The next 4 cases and the parent_check function use the following conventions, where the shaded
#       shaded region is the parent rectangle being checked if it contains the target
#
#Input: Coordinates rect = ((ax, ay), (bx, by)) target = (tx, ty)
#
#Output: True if target is inside shaded region, False otherwise
#
#            ┌────┬─────────┬────────┐           ┌────┬─────────┬────────┐
#   Case 1:  │    │         │        │  Case 2:  │    │         │        │
#            ├────┼─────────┼────────┤           ├────┼─────────┼────────┤
#            │    │#########│        │           │####│         │########│
#            │    │#########│        │           │####│         │########│
#            │    │#########│        │           │####│         │########│
#            ├────┼─────────┼────────┤           ├────┼─────────┼────────┤
#            │    │         │        │           │    │         │        │
#            └────┴─────────┴────────┘           └────┴─────────┴────────┘
#
#            ┌────┬─────────┬────────┐           ┌────┬─────────┬────────┐
#   Case 3:  │    │#########│        │  Case 4:  │####│         │########│
#            ├────┼─────────┼────────┤           ├────┼─────────┼────────┤
#            │    │         │        │           │    │         │        │
#            │    │         │        │           │    │         │        │
#            │    │         │        │           │    │         │        │
#            ├────┼─────────┼────────┤           ├────┼─────────┼────────┤
#            │    │#########│        │           │####│         │########│
#            └────┴─────────┴────────┘           └────┴─────────┴────────┘

def check_case_1(rect, target):
    
    if (is_between(target[0], rect[0][0], rect[1][0]) and is_between(target[1], rect[0][1], rect[1][1])):
        return True
    return False


def check_case_2(rect, target):
    
    if ((not is_between(target[0], rect[1][0], rect[0][0])) and is_between(target[1], rect[0][1], rect[1][1])):
        return True
    return False
    
    
def check_case_3(rect, target):
    
    if (is_between(target[0], rect[0][0], rect[1][0]) and (not is_between(target[1], rect[1][1], rect[0][1]))):
        return True
    return False


def check_case_4(rect, target):
    
    if ((not is_between(target[0], rect[1][0], rect[0][0])) and (not is_between(target[1], rect[1][1], rect[0][1]))):
        return True
    return False

def parent_check(rect, target):
    
    #Input: rect = ((ax, ay), (bx, by)) and target (tx, ty)
    #
    #Output: Returns True if target is inside the rectangle, False otherwise.
    
    ax = rect[0][0]
    ay = rect[0][1]
    bx = rect[1][0]
    by = rect[1][1]
    
    #This is a belabored switch statement. All of these are possible since grids exist on a
    #torus. There's two possibilities for the x coordinates and two for the y as to which one
    #comes first. This gives us the following 4 cases.
    if ( (ax < bx) and (ay < by) ):
        
        return check_case_1(rect, target)
    
    if ( (ax > bx) and (ay < by) ):
        
        return check_case_2(rect, target)
    
    if ( (ax < bx) and (ay > by) ):
        
        return check_case_3(rect, target)
    
    if ( (ax > bx) and (ay > by) ):
        
        return check_case_4(rect, target)
    
    print("invalid rectangle given")


def symbol_coordinates(symbol_perm):

    #Input: List or permutation of symbols (typically X and O) coordinates
    #
    #Output: List of the same size with the cartesian (x,y) coordinates of the symbols if 
    #        the lower left corner of the grid is at (1,1) and the alpha and beta curves are
    #        1 unit apart
    #
    #Note: This could be approached centering the corner at (0,0) the choice of putting it at
    #      (1,1) is so that the generator coordinates are exactly at the height of their given
    #      permutation. That is the state [2,1,3...] has the first intersection at (1,2)
    #
    #Example: call symbol_coordinates([1,3,2])
    
    
    if type(symbol_perm) == perm:
        
        temp = symbol_perm.value.copy()
        
    else:
        
        temp = symbol_perm.copy()
        
    for count, element in enumerate(temp):
        
        temp[count] = (count + 1.5, element + 0.5)
        
    return temp


def hv_set_shift(h,v,sigs): 
    
    #Input: h integer, v integer, sigs a collection of permutations
    #
    #Output: The list of all permutations shifted horizontally by h and vertically by v.
    #        this amounts to setting phi = [1, 2, 3, ... , n] and taking each sig in the 
    #        list and replacing it with (phi^h) o sig o (phi^v)
    
    result = []
    
    if len(sigs) == 0:
        
        n = 0
        
    else:
        
        n = len(sigs[0])
        
    hshift = full_cycle(n)**(-h)
    vshift = full_cycle(n)**v

    for sig in sigs:
        
        result.append((vshift*sig)*hshift)
        
    return result

def deprecated_truncated_sn(n, trunc_length): 
    
    #Input: n integer, trunc_length integer
    #
    #Output: List of lists, each on length trunc_length. One for each sub-sequence
    #        that appears in sn. For example [5,1,6] would be an element for n = 6
    #        and trunc_length = 3, from possibly [5,1,6,3,2,4]

    #We'll make sn then chop off the first trunc_length and save it to result
    pre_result = generate_sn(n)
    result = []
    
    for sig in pre_result:
        
        temp = sig.value.copy()
        trunc_sig = temp[0:trunc_length]
        
        if trunc_sig not in result:
            
            result.append(trunc_sig.copy())
            
    return result


def truncated_sn(n, trunc_length):
    
    result = [[]]
    hold = []
    symset = list(range(1,n+1))
    while len(result[0]) < trunc_length:
        for sym in symset:
            for res in result:
                if not (sym in res):
                    hold.append(res + [sym])
        result = hold
        hold = []
        
    return result
    
    
def generate_all_states_outside_rectangle(rectangle, n): 
    
    #Input: rectangle = ((a0, b0), (a1, b1)), n integer
    #
    #Output: List
    #
    #This function computes the states as if the rectangle had lower corner
    #(1,1) then shifts the result - keep in mind when seeing lists appending 1's
    
    #Compute the dimensions of the rectangle - mod n since we're working on a torus
    r_width = (rectangle[1][0] - rectangle[0][0]) % n
    r_height = (rectangle[1][1] - rectangle[0][1]) % n
    
    if (r_width + r_height) > n:
        
        print("rectangle dimensions too large to have non-empty set of states")
        return []
    
    pre_result = []
    
    #region a is the one above the rectangle and b is the columns after that 
    #then s_a is the collection of intersection choices for a grid state x 
    #that keeps the rectangle empty
    sa = truncated_sn(n - r_height - 1, r_width - 1)
    sb = generate_sn(n - abs(r_width) - 1)  
    #sanity check: 2 intersections used by corners, rw - 1 for a and n - rw - 1 for b means 2 + a + b = n 
    
    #This case should only happen when the rectangle prevents placing any points in 
    #region a (above it)
    if sa == []:
        
        #whats left holds onto the symbols yet to be used
        whats_left = []
        for i in range(2,r_height+1):
            
            whats_left.append(i)
            
        for i in range(r_height+1,n+1):
            
            whats_left.append(i)
            
        for psi in sb:
            
            curr_state=[]
            curr_state.append(1)
            curr_state = [1+r_height] + curr_state
            
            for i in range(n-abs(r_width)-1):
                
                curr_state.append(whats_left[psi[i]-1])
                
            pcurr_state = perm(curr_state.copy())
            pre_result.append(pcurr_state)
    
    #Case for the rest of the rectangles
    for sig in sa:
        
        #we're lifting this as a list rather than a permutation because 
        #we need to shift them all up by the height - making it no longer a perm
        x = sig.copy() 
        
        #loop lifts the symbols above the rectangle into region a
        for count, position in enumerate(x):
            
            x[count] = position + r_height + 1
            
        #whats left holds onto the symbols yet to be used
        whats_left = []
        
        for i in range(2,abs(r_height)+1):
            
            whats_left.append(i)
            
        for i in range(abs(r_height) + 2, n + 1):
            
            if i not in x:
                
                whats_left.append(i)
                
        if sb == []:
        
            curr_state = x.copy()
            curr_state.append(1)
            curr_state = [1+r_height] + curr_state
            pcurr_state = perm(curr_state.copy())
            pre_result.append(pcurr_state)
            
        for psi in sb:
            
            curr_state=x.copy()
            curr_state.append(1)
            curr_state = [1+r_height] + curr_state
            
            for i in range(n-abs(r_width)-1):
                
                curr_state.append(whats_left[psi[i]-1])

            pcurr_state = perm(curr_state.copy())
            pre_result.append(pcurr_state)

    #States need to all be shifted unless the rectangle is actually based at (1, 1)
    if not ((rectangle[0][0] == 1) and (rectangle[0][1] == 1)):
        
        raw_result = hv_set_shift(rectangle[0][0]-1, rectangle[0][1]-1, pre_result)
    
    else:
        
        raw_result = pre_result
        
    result = []
    
    rect_pairer = transposition(rectangle[0][0],rectangle[1][0],n)
    
    #Up to now the raw_results holds the states associated with base of the rectangle
    #this loop takes all those and pairs them with the connected state
    for sig in raw_result:
        result.append([sig*rect_pairer,sig])
        
    if result == []:
        
        return None
    
    return result


def zero_list(n):
    
    #Input: Integer n
    #
    #Output: List of length n with all entries zero --- ex: zero_list(5) = [0, 0, 0, 0, 0]

    result = []
    
    for i in range(n): result.append(0)
    
    return result

def count_symbols(n, rect, symbol_perm):
    
    #Input: n integer, rect rectangle ((a0, b0), (a1, b1)), symbol_perm a permutation or list
    #
    #Output: List with 1/0 for symbol in/out of connecting rectangle
    #
    #Iterates through each symbol symbol_perm(i) and marking a corresponding list entry
    #to 1 if the symbol is present
    
    temp = zero_list(n)
    usable_sym = symbol_coordinates(symbol_perm)
    #Moving the coordinates to the actual heights rather than the discrete style
    #lists
    
    for i in range(n):
        
        if parent_check(rect, usable_sym[i]):
            
            temp[i] = 1
            
    return temp

def generate_all_rectangle_sizes(n):
    
    #Input: n integer
    #
    #Output: All possible sizes of allowable rectangles
    #
    #Any sizes outside of this are too large to not contain a generator's basepoint
    #not to be confused with z/w's.
    
    result = []
    
    for width in range(1,n):
        
        for height in range(1,n+1-width):
            
            result.append((width,height))
            
    return result

def generate_all_rectangles(n):
    
    #Input: n integer
    #
    #Output: All possible connecting rectangles for a grid of size n in a list
    #        format
    
    sizes = generate_all_rectangle_sizes(n)
    rects = []
    
    for size in sizes:
        
        for i in range(0,n):
            
            for j in range(0,n):
                
                x = (i % n + 1,j % n + 1)
                y = ((i+size[0]) % n + 1,(j+size[1]) % n + 1)
                rects.append((x,y))

    return rects

def generate_all_edges(n, symbols): 
    
    #Input: n an integer, symbols, a collection of lists of length n denoting the placement of the symbols. For knots and
    #       links this should be a pair of two lists, or permutations.
    #
    #Output: Returns a list 3 layers deep containing all the edge information of CFKinf
    #
    #Call generate_all_edges(5,[[5, 1, 2, 3, 4], [2, 3, 4, 5, 1]]) as an example
    
    pre_diff = generate_all_rectangles(n)
    symbol_count = len(symbols) #This should always be 2 for knots and links.
    place_holder = []
    z_list = zero_list(n)
    
    for i in range(symbol_count):
        
        place_holder.append(z_list.copy())

    unweighted_diff = []
    
    for rect in pre_diff:

        candidates = generate_all_states_outside_rectangle(rect, n)
        #each candidate is a collection of points differing on the rectangle given
        #so each candidate represents an edge from rect[0] = (a0, b0) to rect[1] = (a1, b1) 
        #(filling in the rest of the necessary coordinates with the candidate)
        
        if candidates is not None:
            
            for count, candidate in enumerate(candidates):
                
                candidates[count] = [candidate.copy(), rect, place_holder.copy()]
                #^Replacing the candidate with a clean copy, a note of its connecting
                #rectangle and initialize the edge weight to zero
                
            unweighted_diff = unweighted_diff + candidates
            #appending the list of these candidates to to our unweighted differential
            
    for count, symbol in enumerate(symbols):
    #This should again always be a pair in case of knots and links
        
        for i in range(len(unweighted_diff)):
        #here we replace the previous zero weight after counting the symbols
            
            unweighted_diff[i][2][count] = count_symbols(n, unweighted_diff[i][1], symbol)
            
    return unweighted_diff


def pickle_it(comp, filename):
    
    #Input: comp is any data (Usually a complex as a networkx type graph) and str filename
    #Exports the complex as a binary file using the pickle module, just shorthand

    file = open(filename, 'wb')
    pickle.dump(comp, file)
    file.close()
    
    return

def build_cinf(symbols):
    
    #Input: symbols a list of two lists, [sigx, sigo]
    #
    #Output: g a networkx directed graph
        
    xlist = symbols[0]
    olist = symbols[1]
    size = len(xlist)

#     if type(symbols) == grid:
        
#         xlist = symbols.sig_x
#         olist = symbols.sig_o    
    
    comp = generate_all_edges(size, [xlist,olist])
    g = nx.DiGraph()
#     nx.set_edge_attributes(g, {'diffweight':[]})
    for ele in comp:
        
        if not g.has_edge(str(ele[0][0]),str(ele[0][1])):

            g.add_edge(str(ele[0][0]),str(ele[0][1]), diffweight = [])
            
        g[str(ele[0][0])][str(ele[0][1])]['diffweight'].append((ele[2][0] + ele[2][1]))
    
    return g


def pickle_cinf(gknot, filename = 'DefaultPickleComp'):

    #Input: Grid or pair of x and o coordinates as list or tuple
    #
    #The function takes the pair calls for the CFK complex to be constructed, loads the
    #result into a networkx directed-graph then calls the function to pickle the resulting
    #graph structure. This is intended to pass to the sage processing from here.
    
    if filename == 'DefaultPickleComp':
        print('No name provided for pickling - saving to DefaultPickleComp')
    
#     if type(gknot) == grid:
        
#         size = gknot.size
#         xlist = list(gknot.sig_x)
#         olist = list(gknot.sig_o)
        
    if (type(gknot) == list) or (type(gknot) == tuple):
        
        size = len(gknot[0])
        xlist = gknot[0]
        olist = gknot[1]

        
    comp = generate_all_edges(size, [xlist,olist])
    g = nx.DiGraph()
    for ele in comp:
        
        g.add_edge(str(ele[0][0]),str(ele[0][1]), diffweight = (ele[2][0] + ele[2][1]))
        
    pickle_it((g, size, gknot), filename)
    
    return


#######################################################################################
#Code in this section is for getting the user input
#######################################################################################

def get_integer_bounded(n):
    
    #Input: integer n
    #
    #Output: An integer input from the user between 1 and n
    
    while True:
        
        num = input()
        
        try:
            
            val = int(num)
            if (val < n + 1) and (val > 0):
                return val
            
            print("Your integer isn't between 1 and " + str(n))
            
        except ValueError:
            
            print("Please only enter an integer.")

def user_sig(n):
    
    #Input: integer n
    #
    #Output: List version of the n entries from the user. Check if valid can be strengthened
    #        in perm.py, as it stands it won't catch any errors in this function
    
    result = []
    print("input the coordinates, returning after each entry")
    
    for i in range(n):
        
        val = get_integer_bounded(n)            
        result.append(int(val))
        
    if check_if_valid(result):
    
        return result
    
    else:
        
        print("Invalid sig entered")
        user_sig(n)

        
def correct_prompt():
    
    #Input: None
    #
    #Output: True if user confirms, False if user specifies, loops until one of the two is given
    
    while True:
        
        ans = input("Is this correct? (Y/N)")
        if (ans == 'Y') or (ans == 'y'): return True
        elif (ans == 'N') or (ans == 'n'): return False
        else: print("You didn't enter Y or N, please only enter one of these options.")
        
        
def prompt_for_link():
    
    #Input: None
    #
    #Output: List of two lists representing sigx and sigo 
    
    sigx = []
    check = False
    sigo = []
    n = int(input("Enter grid size: "))
    
    while True:
        
        print('Grid size = ' + str(n))
        ans = correct_prompt()
        if ans: break
        else: n = int(input('Enter grid size: '))

    print('First enter sigx.')        
    sigx = user_sig(n)

    while check != True:
        
        print("sigx = " + str(sigx))
        ans = correct_prompt()
        if ans: break
        
        else: sigx = user_sig(n)
        
    print('Now enter sigo')
    sigo = user_sig(n)
    
    while check != True:
        
        print("sigo= " + str(sigo))
        ans = correct_prompt()
        if ans: break
        
        else: sigo = user_sig(n)    
    
    return [sigx, sigo]


###############################################################################
#Function call if ran as script
###############################################################################

# def main():
    
#     user_syms = prompt_for_link()
#     fname = str(input('What would you like the pickle (output) to be named: '))
#     pickle_cinf(user_syms, fname)
    
# if __name__ == '__main__':
    
#     main()
