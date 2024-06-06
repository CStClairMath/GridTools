#Code for knot specific variations - should be unnecessary

def gml_export_weighted(self, filename = 'PleaseNameMe.gml'):

    nxG = self.comp.copy()

    if filename == 'PleaseNameMe.gml':
        print("You didn't name your output! It's been named PleaseNameMe.gml")

    if filename[-4:] != ".gml":
        filename += ".gml"

    for x,y in nxG.edges():

        nxG[x][y]['diffweight'] = str(nxG[x][y]['diffweight'])

    for node in nxG.nodes():

        #print(str((nxG.nodes()[node]['UGrading'],nxG.nodes()[node]['VGrading'],nxG.nodes()[node]['AGrading'])))

        try:
            nxG.nodes[node]['AGrading'] = int(nxG.nodes[node]['AGrading']) 
            nxG.nodes[node]['UGrading'] = int(nxG.nodes[node]['UGrading'])
            nxG.nodes[node]['VGrading'] = int(nxG.nodes[node]['VGrading'])
        except:
            nxG.nodes[node]['AGrading'] = int(-99)
            nxG.nodes[node]['UGrading'] = int(-99)
            nxG.nodes[node]['VGrading'] = int(-99)

    nx.write_gml(nxG, filename)

    return

def grade_complex(given_graph, given_field, gridX = -1):
    
    #Input: given_graph a networkx directed graph with 'diffweight' attribute on edges
    #       given_field the laurent polynomial field associated to the grid graph
    #       gridX a list representing the vertex to be graded 0 in U V and Alexander gradings
    #
    #Output: given_graph with new attributes on the vertices for U V and Alexander gradings
    #        also an attribute HasBeenGraded as an artifact
    
    
    #If the positions of the Xs aren't provided we'll initialize around whatever
    #state happens to appear first in the digraph structure
    if gridX == -1:
        
        gridX = list(given_graph.nodes())[0]
    
    gens = given_field.gens()
    size = len(gens)/2 

    print("grading complex...")
    
    #Adding an attribute to all nodes to keep track of if they've been assigned gradings
    nx.set_node_attributes(given_graph, False, "HasBeenGraded")
    
    #The gradings are relative so we're declaring one to be in U, V, and Alexander grading 0
    #this block initializes those balues
    given_graph.nodes()[str(gridX)]['HasBeenGraded'] = True
    given_graph.nodes()[str(gridX)]['AGrading'] = 0
    given_graph.nodes()[str(gridX)]['UGrading'] = 0
    given_graph.nodes()[str(gridX)]['VGrading'] = 0
    
    if TIMERS: timerstart = time.time()

    #Built in function to find a spanning tree
    #span = nx.algorithms.tree.branchings.greedy_branching(given_graph)
    
    tree = nx.algorithms.minimum_spanning_tree( given_graph.to_undirected()  )
    eds = set(tree.edges())  # Issues with functions finding directed spanning set - insteada we find an undirected one then direct it
    spanset = []
    
    for edge in eds:
        
        if edge in given_graph.edges():
            spanset.append(edge)
            
        else:
            spanset.append((edge[1],edge[0]))
        
    span = given_graph.edge_subgraph(spanset)
        
    if TIMERS:
        
        timerstop = time.time()
        print("Time to find arborescence:" + str(timerstop - timerstart))
    
    #Bit of baseball terminology for the following nested loops, the active data is essentially at bat, the list we're working
    #through is called on_deck, and then we're building up the follow up as in_the_hole which will turn into
    #on deck on the following loop
    #
    #On deck holds the edges to be iterated through
    on_deck = [str(gridX)]
    
    #In the hole holds the ones to be iterated through once on_deck is cleared
    in_the_hole = []
    
    if TIMERS: timerstart = time.time()
    
    while len(on_deck) > 0: 
               
        for vert in on_deck:

            #Every vertex in on_deck should be graded. The loops iterate through the neighbors of each of these
            #vertices, grading them and then adding them to in_the_hole, ignoring vertices that have already been graded.
            #
            #The loop is broken into two halves since we have two flavors of neighbor in a directed graph, successors and
            #predecessors, named accordingly. These flavors differ in relative grading change by a sign.
            for succ in span.successors(vert): 
                
                #skip the vertex if its already been graded
                if given_graph.nodes()[succ]['HasBeenGraded']: continue
                    
                in_the_hole.append(succ)
                
                ed_weight = given_graph[vert][succ]['diffweight']
                
                #set the maslov (homological) gradings
                Upows = U_deg(ed_weight, given_field)
                given_graph.nodes()[succ]['UGrading'] = given_graph.nodes()[vert]['UGrading'] - 1 + 2*Upows

                Vpows = V_deg(ed_weight, given_field)
                given_graph.nodes()[succ]['VGrading'] = given_graph.nodes()[vert]['VGrading'] - 1 + 2*Vpows

                #Alexander grading is a function of the U and V grading, set here
                given_graph.nodes()[succ]['AGrading'] = (1/2)*(given_graph.nodes()[succ]['UGrading']-given_graph.nodes()[succ]['VGrading'])

                given_graph.nodes()[succ]['HasBeenGraded'] = True

            for pred in span.predecessors(vert):
                
                if given_graph.nodes()[pred]['HasBeenGraded']: continue
                in_the_hole.append(pred)
                ed_weight = given_graph[pred][vert]['diffweight']
                
                #set the maslov (homological) gradings, note the negative grading change since we're following an arrow backwards.
                Upows = U_deg(ed_weight, given_field)
                given_graph.nodes()[pred]['UGrading'] = given_graph.nodes()[vert]['UGrading'] + 1 - 2*Upows       

                Vpows = V_deg(ed_weight, given_field)
                given_graph.nodes()[pred]['VGrading'] = given_graph.nodes()[vert]['VGrading'] + 1 - 2*Vpows

                given_graph.nodes()[pred]['AGrading'] = (1/2)*(given_graph.nodes()[pred]['UGrading']-given_graph.nodes()[pred]['VGrading'])
                given_graph.nodes()[pred]['HasBeenGraded'] = True
                
        on_deck = in_the_hole
        in_the_hole =[]
        
    if TIMERS:
        
        timerstop = time.time()
        print('Time to grade complex (given arborescence): ' + str(timerstop - timerstart))
    
    return given_graph
            

    
def U_deg(poly, field):
    
    #Input: poly a laurent polynomial (must be  a monomial) in field a laurent polynomial ring
    #
    #Output: The total sum of powers of Ui in poly
    
    gens = field.gens()
    size = len(gens)/2
    degree = 0
    
    if type(poly) == sage.rings.finite_rings.integer_mod.IntegerMod_int: return 0
    
    powers = poly.exponents()   
    
    #len(powers) tells you how many terms the polynomial has
#     if len(powers) > 1:
        
#         print(poly)
        
#         raise Exception("Ran into a non-homogoneous degree change - polynomial wasn't a monomial")

    if len(powers) == 0:
        
        return 0    
    
    #powers is a list of lists since its intended for more than just monomials, since we are guaranteeing
    #a monomial at this point we'll just lift that inner list out
    powers = powers[0]
    
    for i in range(size):
        
        degree = degree + powers[i]
    
    return degree

    
def V_deg(poly, field):
    
    #Input: poly a laurent polynomial (must be  a monomial) in field a laurent polynomial ring
    #
    #Output: The total sum of powers of Ui in poly    
    
    gens = field.gens()
    size = len(gens)/2
    degree = 0
    
    if type(poly) == sage.rings.finite_rings.integer_mod.IntegerMod_int: return 0
    
    powers = poly.exponents()   
    
    #len(powers) tells you how many terms the polynomial has    
#     if len(powers) > 1:
        
#         print(poly)
#         raise Exception("Ran into a non-homogoneous degree change - polynomial wasn't a monomial")

    if len(powers) == 0:
        
        return 0    
    
    #powers is a list of lists since its intended for more than just monomials, since we are guaranteeing
    #a monomial at this point we'll just lift that inner list out    
    powers = powers[0]
    for i in range(size):
        
        degree = degree + powers[size + i]
    
    return degree    
    