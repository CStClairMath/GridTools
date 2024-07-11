import itertools as itools
import networkx as nx
import csv
# import ast
# import numpy as np
from scipy import sparse
import matplotlib.pyplot as plt
import multiprocessing as mp
#from sage.graphs.graph_decompositions.graph_products import is_cartesian_product
import GFKTools as gfk
from GridPermutations import *
import time
import pickle
import perm as pr
from multiprocessing.managers import BaseManager
import random as rd

full_dict = {**knot_dict, **link_dict}

TIMERS = True
PROCESSOR_COUNT = mp.cpu_count()
PARALLEL_CUTOFF = 400
OUTPUTDIRECTORY = 'Outputs/'
PRINT_PROGRESS = True

class MyManager(BaseManager):

    # Necessary class definition for parallel processing

    pass

class grid_complex:
    
    # This is the data type that holds all the information and most of the functions and methods necessary
    # to produce and manipulate the graded complex.
    
    def __init__(self, directed_graph, rng, sigx = None, sigo = None):
    
    # Initializing and setting default values. sigx and sigo should generally be provided - fail safes are included
    # however if they're ever used then only the relative grading of the final object will be correct
    
        if type(directed_graph) != nx.DiGraph:
            raise("!This data type only supports networkx digraphs!")
        
        self.comp = directed_graph
        self.ring = rng
        self.min_gradings = {}
        self.max_gradings = {}
        self.max_grading_changes = {}
        self.sigx = sigx
        self.sigo = sigo
        self.set_to_minus = False
        self.set_to_tilde = False
        
        # From here the values necessary for the surgered manifold gradings are mapped out
        
        if (sigx != None) and (sigo != None):
            self.size = len(sigx)
            self.components = link_components(sigx, sigo)
            for i in range(len(self.components)):

                key = f'AGrading{i}'
                self.min_gradings[key] = 0
                self.max_gradings[key] = 0
                self.max_grading_changes[key] = 0
                key = f'UGrading{i}'
                self.min_gradings[key] = 0
                self.max_gradings[key] = 0
                self.max_grading_changes[key] = 0
                key = f'VGrading{i}'
                self.min_gradings[key] = 0
                self.max_gradings[key] = 0
                self.max_grading_changes[key] = 0
        else:
            
        # This is included in case the methods in the class are useful to another complex being loaded in
        
            self.components = None
        
        
    def __repr__(self):

        # If the object is called it will return the underlying digraph
        return self.comp
    
    def subcomplex(self, subgraph):

        # This is essentially just the subgraph - may not be an actual subcomplex if poor choice of vertices/edges are made
        sub_copy = subgraph.copy()
        result = grid_complex(sub_copy, self.ring)
        
    
    def copy(self):

        # Adds copy functionality like the copy module
        if self.sigx == None:
            new_copy = grid_complex(self.comp.copy(), self.ring)
        else:
            new_copy = grid_complex(self.comp.copy(), self.ring, self.sigx.copy(), self.sigo.copy())
        return new_copy
    
    def grid(self):        
        # Adding functionality to return the original grid that produced the complex
        return [self.sigx, self.sigo]

    
    def graph(self):
        return self.comp
    
    def ring(self):
        return self.ring
    
    
    
    def to_hat(self):

        # Substitutes 0 for all the U and V variables in the complex

        print("setting Ui's and Vi's = 0")
        gens = self.ring.gens()
        size = len(gens)/2    
        for edge in self.comp.edges():

            for i in range(2*size):

                src = edge[0]
                tar = edge[1]
                self.comp[src][tar]['diffweight'] = self.comp[src][tar]['diffweight'].subs({gens[i]:0})

        return
    
    
    def to_minus(self):

        # Substitutes U0 for all the Ui and 1 for Vi

        self.set_to_minus = True
        print("normalizing Ui's and setting Vi = 1")
        gens = self.ring.gens()
        size = len(gens)/2    
        for edge in self.comp.edges():

            for component in self.components:
                for i in component:

                    # if i == component[0]: continue
                    setting_var = component[0] - 1
                    src = edge[0]
                    tar = edge[1]
                    self.comp[src][tar]['diffweight'] = self.comp[src][tar]['diffweight'].subs({gens[i-1]:gens[setting_var]})
                    self.comp[src][tar]['diffweight'] = self.comp[src][tar]['diffweight'].subs({gens[i+size-1]:1})

        self.remove_zeros()
        return


    def to_tilde(self, overwrite = True):

        # Converts the complex to the tilde flavor by setting all the U's and V's to 0
        # overwrite option determines whether to apply it to the complex or to make a copy and apply
        # the changes there.

        if overwrite == False:

            replacement = self.copy()
            return replacement.to_tilde()

        self.set_to_tilde = True
        print("Setting all U's and V's to 0")
        gens = self.ring.gens()
        size = len(gens)/2    

        for edge in self.comp.edges():

            for i in range(2*size):

                src = edge[0]
                tar = edge[1]
                self.comp[src][tar]['diffweight'] = self.comp[src][tar]['diffweight'].subs({gens[i]:0})

        self.remove_zeros()

        return self

    def link_normalize(self):

        # Substitutes Ucomp for all the Ui associated to that component

        gens = self.ring.gens()
        size = len(gens)/2    
        for edge in self.comp.edges():

            for component in self.components:
                for i in component:

                    if i == component[0]: continue
                    setting_var = component[0] - 1
                    src = edge[0]
                    tar = edge[1]
                    self.comp[src][tar]['diffweight'] = self.comp[src][tar]['diffweight'].subs({gens[i-1]:gens[setting_var]})
                    self.comp[src][tar]['diffweight'] = self.comp[src][tar]['diffweight'].subs({gens[i+size-1]:gens[size+setting_var]})

        self.remove_zeros()
        return

    
#     def normalize(self):
#     #Substitutes U0 for all the Ui and V0 for all Vi

#         gens = self.field.gens()
#         size = len(gens)/2    
#         for edge in self.comp.edges():

#             for i in range(size):

#                 src = edge[0]
#                 tar = edge[1]
#                 self.comp[src][tar]['diffweight'] = self.comp[src][tar]['diffweight'].subs({gens[i]:gens[0]})
#                 self.comp[src][tar]['diffweight'] = self.comp[src][tar]['diffweight'].subs({gens[i+size]:gens[size]})

#         self.remove_zeros()
#         return

    def remove_zeros(self):

    # Searches the complex for edges with weight 0 and removes the edge

        elist = list(self.comp.edges())
        for x,y in elist:

            if self.comp[x][y]['diffweight'] == 0:

                self.comp.remove_edge(x,y)

        return



    
    def graph_red_search(self, started = False, timerstart = None): 

        # searches through a cfk inf complex for reducible edges and calling
        # the reduction function to eliminate the pair according to the reduction algorithm
        
        if not started:
            timerstart = time.time()    
            print("Reducing complex...")
        
        print(len([source for source, target, weight in self.comp.edges(data = 'diffweight') if weight == 1]))
        while True:
#             count = (count + 1)%
            try:
                red_target = next((source, target) for source, target, weight in self.comp.edges(data = 'diffweight') if weight == 1)
#                 print(self.comp.edges[red_target])
                self.graph_reduction(red_target[0], red_target[1])
                continue
            except:
                ("StopIteration")
            break

        timerstop = time.time()
        # print('Time to reduce complex: ' + str(timerstop - timerstart))

        return

    def graph_reduction(self, key, target):

        # Deletes edge specified from graph_red_search and adds in edges according to the
        # reduction algorithm

        for x in self.comp.predecessors(target):

            if x == key: continue
            for y in self.comp.successors(key):

                if y == target: continue
                x_weight = self.comp[x][target]['diffweight']
                y_weight = self.comp[key][y]['diffweight']
                red_weight = x_weight * y_weight
                if self.comp.has_edge(x,y):
                    old_weight = self.comp[x][y]['diffweight']
                    red_weight = red_weight + old_weight
                self.comp.add_edge(x,y,diffweight=red_weight)

        self.comp.remove_node(key)
        self.comp.remove_node(target)
        return


    def minus_reduction(self, overwrite = True):
    
        # Reduces the complex but only reducing edges between vertices that are in the same Alexander gradings
        # Note: This will not overwrite (regardless of argument) if the complex hasn't been converted to the minus flavor. Instead, it
        # will make a copy, do the reduction there, and return the new complex

        if self.set_to_minus == False:
            replacement = self.copy()
            replacement.to_minus()
            replacement.minus_reduction(True)

        if overwrite == False:
            replacement = self.copy()
            replacement.minus_reduction(True)

        while True:

            starting_edge_count = len([source for source, target, weight in self.comp.edges(data = 'diffweight') if (weight == 1 and alexander_grading_equivalent(self.comp, source, target, len(self.components)))])

            try:

                source, target = next((source, target) for source, target, weight in self.comp.edges(data = 'diffweight') if (weight == 1 and alexander_grading_equivalent(self.comp, source, target, len(self.components))))
                print("my alexander function returned " + str(alexander_grading_equivalent(self.comp, source, target, len(self.components))))
                print(self.comp.nodes()[source]["AGrading0"])
                print(self.comp.nodes()[target]["AGrading0"])
                # print(self.comp.nodes()[source]["AGrading1"])
                self.graph_reduction(source, target)
            except StopIteration:
                pass
            except:
                print("Unexpected Error")

            end_edge_count = len([source for source, target, weight in self.comp.edges(data = 'diffweight') if (weight == 1 and alexander_grading_equivalent(self.comp, source, target, len(self.components)))])

            if starting_edge_count == end_edge_count:

                break

        return self


    def grade_link_complex(self):

        # Input: given_graph a networkx directed graph with 'diffweight' attribute on edges
        #        given_field the laurent polynomial field associated to the grid graph
        #        gridX a list representing the vertex to be graded 0 in U V and Alexander gradings
        #
        # Output: given_graph with new attributes on the vertices for U V and Alexander gradings
        #         also an attribute HasBeenGraded as an artifact


        # If the positions of the Xs aren't provided we'll initialize around whatever
        # state happens to appear first in the digraph structure - This will mean the complex's absolute grading will be off
        if self.sigx == None:

            gridX = list(self.comp.nodes())[0]
            
        else:
            
            gridX = self.sigx
            cycle = pr.full_cycle(self.size)
            gridX = pr.perm(gridX)
            gridX = cycle*gridX
            gridX = gridX.value

        if self.sigo == None:

            gridO = list(self.comp.nodes())[0]
            
        else:
            
            gridO = self.sigo
            cycle = pr.full_cycle(self.size)
            gridO = pr.perm(gridO)
            gridO = cycle*gridO
            gridO = gridO.value
            
        gens = self.ring.gens()
        size = len(gens)/2 

        print("grading complex...")

        comp_count = len(self.components)

        # Adding an attribute to all nodes to keep track of if they've been assigned gradings
        for i in range(comp_count):
            nx.set_node_attributes(self.comp, False, f"HasBeenGraded{i}")

        # The gradings are relative so we're declaring one to be in U, V, and Alexander grading 0
        # this block initializes those balues
        # for i in range(comp_count):
#             self.comp.nodes()[str(gridX)][f'HasBeenGraded{i}'] = True
            # self.comp.nodes()[str(gridX)][f'AGrading{i}'] = 0
#             self.comp.nodes()[str(gridX)][f'UGrading{i}'] = 0
#             self.comp.nodes()[str(gridX)][f'VGrading{i}'] = 0

        if TIMERS: timerstart = time.time()

        # Built in function to find a spanning tree
        #span = nx.algorithms.tree.branchings.greedy_branching(given_graph)

        tree = nx.algorithms.minimum_spanning_tree( self.comp.to_undirected()  )
        eds = set(tree.edges())  # optimization
        spanset = []

        for edge in eds:

            if edge in self.comp.edges():
                spanset.append(edge)

            else:
                spanset.append((edge[1],edge[0]))

        span = self.comp.edge_subgraph(spanset)

        if TIMERS:

            timerstop = time.time()
            print("Time to find arborescence:" + str(timerstop - timerstart))

        # Bit of baseball terminology for the following nested loops, the active data is essentially at bat, the list we're working
        # through is called on_deck, and then we're building up the follow up as in_the_hole which will turn into
        # on deck on the following loop
        #
        # On deck holds the edges to be iterated through
        # on_deck = [str(gridX)]

        # In the hole holds the ones to be iterated through once on_deck is cleared
        # in_the_hole = []

        if TIMERS: timerstart = time.time()

        # Grading Loops Start:
        ####################
        
        self.componentwise_relative_grading_loop("UGrading", gridX, self.virtual_U_gradings_succ, self.virtual_U_gradings_pred, span, comp_count)
        self.componentwise_relative_grading_loop("VGrading", gridO, self.virtual_V_gradings_succ, self.virtual_V_gradings_pred, span, comp_count)
        self.relative_grading_loop("UGrading", gridX, self.maslov_U_succ, self.maslov_U_pred, span, comp_count)
        self.relative_grading_loop("VGrading", gridO, self.maslov_V_succ, self.maslov_V_pred, span, comp_count)
        
        ####################
        # Grading Loops End

        for vert in self.comp.nodes():
            self.comp.nodes()[vert]['AGrading'] = 0          
            for i in range(len(self.components)):
                stab_count = len(self.components[i])
                self.comp.nodes()[vert][f'AGrading{i}'] = (1/2)*(self.comp.nodes()[vert][f'VGrading{i}']-self.comp.nodes()[vert][f'UGrading{i}'])-(1/2)*(stab_count - 1)
                self.comp.nodes()[vert]['AGrading'] += self.comp.nodes()[vert][f'AGrading{i}']
        if TIMERS:

            timerstop = time.time()
            print('Time to grade complex (given arborescence): ' + str(timerstop - timerstart))

        return

    def gml_export(self, filename = 'PleaseNameMe.gml'):

        # Exports the graph as a gml file which can be opened in a program like Gephi

#         if component_length == -1:
#             return("!!! Unknown number of components for export !!!")

        component_length = len(self.components)
        
        if component_length == 0:
            raise("Error finding number of components")
        
        nxG = self.comp.copy()

        if filename == 'PleaseNameMe.gml':
            print("You didn't name your output! It's been named PleaseNameMe.gml")

        if filename[-4:] != ".gml":
            
            return self.gml_export(filename + ".gml")
            # filename += ".gml"

        for x,y in nxG.edges():

            nxG[x][y]['diffweight'] = str(nxG[x][y]['diffweight'])

        for node in nxG.nodes():

            #print(str((nxG.nodes()[node]['UGrading'],nxG.nodes()[node]['VGrading'],nxG.nodes()[node]['AGrading'])))
            try:
                nxG.nodes[node]['UGrading'] = int(nxG.nodes[node]['UGrading'])
                nxG.nodes[node]['VGrading'] = int(nxG.nodes[node]['VGrading'])
                nxG.nodes[node]['AGrading'] = int(nxG.nodes[node]['AGrading'])
            except:
                nxG.nodes[node]['UGrading'] = int(-99)
                nxG.nodes[node]['VGrading'] = int(-99)
                nxG.nodes[node]['AGrading'] = int(-99)
            for i in range(component_length):
                try:
                    nxG.nodes[node][f'AGrading{i}'] = int(nxG.nodes[node][f'AGrading{i}']) 
                    nxG.nodes[node][f'UGrading{i}'] = int(nxG.nodes[node][f'UGrading{i}'])
                    nxG.nodes[node][f'VGrading{i}'] = int(nxG.nodes[node][f'VGrading{i}'])
                except:
                    nxG.nodes[node][f'AGrading{i}'] = int(-99)
                    nxG.nodes[node][f'UGrading{i}'] = int(-99)
                    nxG.nodes[node][f'VGrading{i}'] = int(-99)

        print("writing to " + OUTPUTDIRECTORY + str(filename))
        nx.write_gml(nxG, OUTPUTDIRECTORY + filename)

        return

  
    def find_grading_ranges(self, key = "AGrading"):

        # Finds the minimum and maximum gradings among the vertices associated with a grading key

        self.min_gradings[key] = 0
        self.max_gradings[key] = 0
        
        for vert in self.comp.nodes():

            if self.comp.nodes[vert][key] < self.min_gradings[key]:

                self.min_gradings[key] = self.comp.nodes[vert][key]

            if self.comp.nodes[vert][key] > self.max_gradings[key]:

                self.max_gradings[key] = self.comp.nodes[vert][key]

        return

    
    def comp_truncate(self, grading_cutoff):

        # Grading cutoff should be a tuple of values, this function will
        # I've only considered this for calling after converting to minus complex

        generators = self.ring.gens()
        for i in range(len(self.components)):
            for vert in self.comp:

                if self.comp.nodes()[vert][f"AGrading{i}"] >= grading_cutoff[i]:
                    self.comp.nodes()[vert][f"AGrading{i}"] += 1
                    self.comp.nodes()[vert][f"UGrading{i}"] += -2

                    for targ in self.comp.successors(vert):

                        self.comp[vert][targ]['diffweight'] = self.comp[vert][targ]['diffweight']*generators[i]

                    for pred in self.comp.predecessors(vert):

                        self.comp[pred][vert]['diffweight'] = self.comp[pred][vert]['diffweight']*(generators[i]^(-1))

        return
    
    def surgery(self, grading_list = None, target_grading = None):

        # Creates a copy of the graph and truncates it below every combination of Alexander gradings
        # and reduces the resulting complexes then writes them out

        if grading_list == None:
            
            grading_list = []
            
            for i in range(len(self.components)):
                self.find_grading_ranges(f"AGrading{i}")

            for i in range(len(self.components)):
                grading_list.append(self.max_gradings[f"AGrading{i}"])
                        
        if target_grading == None:
            
            target_grading = []
            for i in range(len(self.components)):
                target_grading.append(self.min_gradings[f"AGrading{i}"])
        
        print("target gradings = " + str(target_grading))
        print("max gradings = " + str(grading_list))
        if self.set_to_minus == False:
            
            print("This complex hasn't been converted to minus. Making a copy of the complex and converting it to the minus complex")
            minus_copy = self.copy()
            minus_copy.to_minus()
            minus_copy.surgery(grading_list, target_grading)
            print("uhh didn't expect to be here...")
    
        grading_ranges = []
        
        for i in range(len(target_grading)):
            
            grading_ranges.append(list(range(target_grading[i], grading_list[i]+1)))
        
        sub_gradings = itools.product(*grading_ranges)
        
        for grading in sub_gradings:
            
            specimen = self.copy()
            specimen.comp_truncate(grading)
            specimen.graph_red_search()
            specimen.remove_zeros()
            specimen.gml_export(str(self.sigx) + str(self.sigo) + "surgery" + str(grading))
        
        return

    
    def relative_grading_loop(self, grading_key, base_vertex, fn1, fn2, span = None, grading_multiplicity = 1):

        # Loop structure around a vertex's neighbors to set gradings based on the functions fn1 and fn2.

        if span == None:
            
            span = self.comp
        

        nx.set_node_attributes(self.comp, False, "HasBeenGraded")
        self.comp.nodes()[str(base_vertex)][f'HasBeenGraded'] = True
        self.comp.nodes()[str(base_vertex)][f'{grading_key}'] = 0

        on_deck = [str(base_vertex)]
        
        in_the_hole = []

        while len(on_deck) > 0: 

            for vert in on_deck:

                # Every vertex in on_deck should be graded. The loops iterate through the neighbors of each of these
                # vertices, grading them and then adding them to in_the_hole, ignoring vertices that have already been graded.
                #
                # The loop is broken into two halves since we have two flavors of neighbor in a directed graph, successors and
                # predecessors, named accordingly. These flavors differ in relative grading change by a sign.

                # for i, component_columns in enumerate(self.components):
                for succ in span.successors(vert): 

                    #skip the vertex if its already been graded
                    if self.comp.nodes()[succ]['HasBeenGraded']: continue
                    
                    in_the_hole.append(succ)
                    
                    fn1(succ, vert)

                    self.comp.nodes()[succ]['HasBeenGraded'] = True

                for pred in span.predecessors(vert):

                    if self.comp.nodes()[pred]['HasBeenGraded']: continue
                    
                    in_the_hole.append(pred)
                    
                    fn2(pred, vert)

                    self.comp.nodes()[pred][f'HasBeenGraded'] = True
                        
            on_deck = in_the_hole
            in_the_hole = []
                                                
        return

    
    def componentwise_relative_grading_loop(self, grading_key, base_vertex, fn1, fn2, span = None, grading_multiplicity = 1):

        # Loop structure around a vertex's neighbors to set gradings based on the functions fn1 and fn2, passing
        # the functions are passed component information as well

        if span == None:
            
            span = self.comp
        
        for i in range(grading_multiplicity):

            nx.set_node_attributes(self.comp, False, f"HasBeenGraded{i}")
            self.comp.nodes()[str(base_vertex)][f'HasBeenGraded{i}'] = True
            self.comp.nodes()[str(base_vertex)][f'{grading_key}{i}'] = 0

        on_deck = [str(base_vertex)]
        
        in_the_hole =[]

        while len(on_deck) > 0: 

            for vert in on_deck:

                # Every vertex in on_deck should be graded. The loops iterate through the neighbors of each of these
                # vertices, grading them and then adding them to in_the_hole, ignoring vertices that have already been graded.
                #
                # The loop is broken into two halves since we have two flavors of neighbor in a directed graph, successors and
                # predecessors, named accordingly. These flavors differ in relative grading change by a sign.
                for i, component_columns in enumerate(self.components):
                    for succ in span.successors(vert): 

                        #skip the vertex if its already been graded
                        if self.comp.nodes()[succ][f'HasBeenGraded{i}']: continue
                        
                        in_the_hole.append(succ)
                        
                        fn1(i, succ, vert, component_columns)

                        self.comp.nodes()[succ][f'HasBeenGraded{i}'] = True

                    for pred in span.predecessors(vert):

                        if self.comp.nodes()[pred][f'HasBeenGraded{i}']: continue
                        
                        in_the_hole.append(pred)
                        
                        fn2(i, pred, vert, component_columns)

                        self.comp.nodes()[pred][f'HasBeenGraded{i}'] = True
                        
            on_deck = in_the_hole
            in_the_hole = []
                        
        return
# The following block of function definitions are the supporting functions for the grading loops
# These are passed as fn1 and fn2 to the grading loops in the grading function
#########################################

    def virtual_U_gradings_pred(self, i, pred, vert, component_columns):

        ed_weight = self.comp[pred][vert]['diffweight']

        Upows = link_U_deg(ed_weight, self.ring, component_columns)
        self.comp.nodes()[pred][f'UGrading{i}'] = self.comp.nodes()[vert][f'UGrading{i}'] + 1 - 2*Upows
        
        return

    def virtual_U_gradings_succ(self, i, succ, vert, component_columns):        
        
        ed_weight = self.comp[vert][succ]['diffweight']

        Upows = link_U_deg(ed_weight, self.ring, component_columns)
        self.comp.nodes()[succ][f'UGrading{i}'] = self.comp.nodes()[vert][f'UGrading{i}'] - 1 + 2*Upows
    
        return

    def virtual_V_gradings_pred(self, i, pred, vert, component_columns):

        ed_weight = self.comp[pred][vert]['diffweight']

        Vpows = link_V_deg(ed_weight, self.ring, component_columns)
        self.comp.nodes()[pred][f'VGrading{i}'] = self.comp.nodes()[vert][f'VGrading{i}'] + 1 - 2*Vpows
        
        return

    def virtual_V_gradings_succ(self, i, succ, vert, component_columns):        
        
        ed_weight = self.comp[vert][succ]['diffweight']

        Vpows = link_V_deg(ed_weight, self.ring, component_columns)
        self.comp.nodes()[succ][f'VGrading{i}'] = self.comp.nodes()[vert][f'VGrading{i}'] - 1 + 2*Vpows
              
        return
            
    def maslov_U_pred(self, pred, vert):

        ed_weight = self.comp[pred][vert]['diffweight']
        
        component_columns = self.sigx
        
        Upows = link_U_deg(ed_weight, self.ring, component_columns)
        self.comp.nodes()[pred]['UGrading'] = self.comp.nodes()[vert]['UGrading'] + 1 - 2*Upows        
        
        return
        
    def maslov_U_succ(self, succ, vert):
        
        ed_weight = self.comp[vert][succ]['diffweight']

        component_columns = self.sigx
        
        Upows = link_U_deg(ed_weight, self.ring, component_columns)
        self.comp.nodes()[succ]['UGrading'] = self.comp.nodes()[vert]['UGrading'] - 1 + 2*Upows

        return
        
    def maslov_V_pred(self, pred, vert):

        ed_weight = self.comp[pred][vert]['diffweight']

        component_columns = self.sigo
        
        Vpows = link_V_deg(ed_weight, self.ring, component_columns)
        self.comp.nodes()[pred]['VGrading'] = self.comp.nodes()[vert]['VGrading'] + 1 - 2*Vpows        
        
        return
        
    def maslov_V_succ(self, succ, vert):
        
        ed_weight = self.comp[vert][succ]['diffweight']

        component_columns = self.sigo
        
        Vpows = link_V_deg(ed_weight, self.ring, component_columns)
        self.comp.nodes()[succ]['VGrading'] = self.comp.nodes()[vert]['VGrading'] - 1 + 2*Vpows

        return
    
    #########################################
    # End of relative grading support functions


    def find_max_difference(self, key_set):

        # For a given set of keys this function iterates through the graph and finds the largest difference. This could be improvable
        # speed-wise by considering edges instead but as it stands the grading would have to be recomputed since that data is
        # recorded in  the vertices instead. So in its current state that would be more expensive in processing and this is cheaper
        # memory wise regardless.
    
        if type(key_set) == str:
            key_set = [key_set]
        
        for key in key_set:
            self.max_grading_changes[key] = 0
        
        result = 0
        for vert in self.comp.nodes():
            for nb in self.comp.neighbors(vert):
                for key in key_set:
                    if (abs(self.comp.nodes()[vert][key] - self.comp.nodes()[nb][key])) > self.max_grading_changes[key]:
                        print("setting value")
                        self.max_grading_changes[key] = abs(self.comp.nodes()[vert][key] - self.comp.nodes()[nb][key])
    
        return
    

    
    def parallel_reduction_helper(self, subgraph_set, overwrite = True):
        
        print("running parallel_reduction_helper")
        process_dict = {}
        for count, subgraph in enumerate(subgraph_set):
            
            process_dict[count] = mp.Process(target = subgraph[0].range_graph_red_search(), args = subgraph[1] )
            process_dict[count].start()
        
        for proc in process_dict:
            
            proc.join()
        
        result = subgraph_set[0][0]
        
        for subgraph in subgraph_set:
            
            result = nx.compose(result, subgraph)
        
        if overwrite:
            
            self.comp = result
            return
        
        else:
            
            return result
    


    def ego_parallel_red_search(self, cutoff = PARALLEL_CUTOFF, proc_count = PROCESSOR_COUNT):

        # graph_red_search with parallel processing support by using networkx ego graph function
        # to split the graph
        
        if len([source for source, target, weight in self.comp.edges(data = 'diffweight') if weight == 1]) > cutoff:
            print("entering parallel reduction")
        while len([source for source, target, weight in self.comp.edges(data = 'diffweight') if weight == 1]) > cutoff:
               print(str(len([source for source, target, weight in self.comp.edges(data = 'diffweight') if weight == 1])) + "reducible edges remaining")
               reducible_edge = rd.sample([source for source, target, weight in self.comp.edges(data = 'diffweight') if weight == 1], 1)
               
               self.ego_parallel_sweep(reducible_edge[0], proc_count)
        print("parallel reduction complete")
        self.graph_red_search()
        
        return
    
    
    def ego_parallel_sweep(self, start_vert = None, proc_count = PROCESSOR_COUNT):

        if start_vert == None:
            
            start_vert = self.comp.nodes()[0]
        
        size = len(list(self.comp.nodes)[0])
#         (self.comp.nodes[0])
        ego_bands, safety = ego_split(self.comp, start_vert, size)
        
        partition_data = ego_region_partition(size)
        
        parallel_subgraph_packer(self.comp, ego_bands, partition_data, self.ring)
        
        region_count = len(partition_data)
        count = 0 
        MyManager.register('list', list)
        with MyManager() as manager:
            processed_subgraphs = manager.list()
            while count < region_count:

                process_dict = {}

                for i in range(proc_count):

                    if count < region_count:

#                         processed_subgraphs = []
                        process_dict[count] = mp.Process(target = subgraph_red_search, args = (partition_data[f"block{count}"]['total_region'],partition_data[f"block{count}"]['search_region'], processed_subgraphs))
                        process_dict[count].start()
                        count += 1

                # print("Assigned parallel jobs, waiting for them to finish")
                for proc in process_dict:
                    # print(proc)
                    process_dict[proc].join()

                # print("count = " + str(count) + "region_count = " + str(region_count))     
            processed_subgraphs = processed_subgraphs._getvalue()    
            # print("replacing parent graph...")
            result = processed_subgraphs[0].comp
        
        for element in processed_subgraphs:
            
            result = nx.compose(result, element.comp)

        result = nx.compose(result, safety)
            
        # print('reduced total graph from ' +  str(len(self.comp.nodes())), end = "")
        
        self.comp = result

        self.remove_zeros()
        # print(' to ' +  str(len(self.comp.nodes())))
        
        return
    

    def newton_poly(self):

    #Associates a polynomial to a complex by taking each vertex as a
    #polynomial = \product t_i^(Alexander grading i) and summing

        alex_vars = name_some_vars(['t'], len(self.components))

        # R = LaurentPolynomialRing(ZZ, alex_vars + ['u'])
        alex_names = alex_vars +['u']
        alex_vars = var(alex_names)
        # alex_vars = R.gens()
        u = alex_vars[-1]
        result = 0

        for vert in self.comp.nodes():

            adding_poly = 1
            for i in range(len(self.components)):

                pow = self.comp.nodes()[vert][f'AGrading{i}']
                if pow != 0:
                    # print(vert)
                    # print(str(alex_vars[i]))
                    # print(pow)
                    adding_poly = adding_poly*(alex_vars[i]**pow)

            pow = self.comp.nodes()[vert]['UGrading']
            if pow != 0:
                adding_poly = adding_poly*(u**pow)
            result += adding_poly

        return result

    def pickle_edge_dict(self, filename):

        edge_dict = dict(self.comp.edges())
        gfk.pickle_it(edge_dict, filename)

        return

    def pickle_node_dict(self, filename):

        node_dict = dict(self.comp.nodes())
        gfk.pickle_it(node_dict, filename)

        return



def subgraph_red_search(subg, search_reg, result_list):

    # graph_red_search limited to the subgraph search_reg, results are appended to result_list
    # which in practice is a proxy list object handled by a multiprocessing manager

    subgraph = subg.copy()
    search_region = search_reg.copy()
    og_size = len(subgraph.comp.nodes())
    for ed in [edge for edge in search_region.comp.edges() if search_region.comp.edges[edge]['diffweight'] == 1]:
#         print("identified edge " + str(ed) + " for reduction")
#         print("nodes of subg" + str(subgraph.comp.nodes()))
#         print("nodes of search region" + str(search_region.comp.nodes()))
        
        if ed in subgraph.comp.edges():
#             print("reducing an edge")
            if (subgraph.comp.edges()[ed]['diffweight'] == 1):
                subgraph.graph_reduction(ed[0], ed[1])
        
    f_size = len(subgraph.comp.nodes())
    # print("reduced subgraph from size " + str(og_size) + " to " + str(f_size))
    result_list.append(subgraph)
#     print("running change result length = " + str(len(result_list)))
            
    return
    

def ego_split(graph, vertex, n):

    # Returns a list of collections of vertices whose index is also their distance from the provided vertex
    # Safety is provided to catch any separate components.
    
    result = []
    
    for i in range(n):
        
        result.append(nx.ego_graph(graph, vertex, i))
        
    safety = graph.copy()
    
    safety.remove_nodes_from(result[n - 1].nodes())
        
    for i in range(n-1, 0, -1):
        
        result[i].remove_nodes_from(result[i-1].nodes())
        
    return result, safety

def ego_region_partition(n):
    
    # Returns a dictionary of dictionaries which indicate the regions that are going to be reduced and
    # preserved during the parallel reduction

    result = {}
    
    split_count = math.ceil(n/4)
    
    result["block0"] = {"search_region": [0,1] , "reserved_region": [2]}
    
    for i in range(1,split_count):
        
        result[f"block{i}"] = {"search_region" : [3*i, 3*i+1], "reserved_region" : [3*i-1,3*i+2]}
        
    return result

def parallel_subgraph_packer(graph, subgraphs, region_data, ring):

    # Takes the collections of vertices (intended for those from ego_split) as subgraphs from a parent
    # graph and joins them up as subgraphs based on region_data. ring is provided to construct grid_complex objects
    # from the resulting graphs.

    # region_data should be a dict of dicts with inner dict data labeled "search_region" and "reserved_region"
    # the outer data should be labeled f"block{i}". See ego_region_partition for an example function that works
    # with this
    
    # subgraphs should be a list of subgraphs corresponding to the region data specified above
    
    for data in region_data:
#         print(region_data[data])
        
        region_nodes = []
        
        # unpacking the indices of the subgraphs we were passed - so we need to unpack 3
        # layers deep in total
        
        for region in region_data[data]:    
            for i in region_data[data][region]:
#                 print(type(subgraphs[i]))

                region_nodes += (list(subgraphs[i].nodes()))
        
        packed_subgraph = graph.subgraph(region_nodes)
        
        region_data[data]['total_region'] = grid_complex(packed_subgraph, ring)
    
    
    for data in region_data:
        
        region_nodes = []
        
        for i in region_data[data]['search_region']:
        
            region_nodes += list(subgraphs[i].nodes())
            
        packed_subgraph = graph.subgraph(region_nodes)
        
        region_data[data]['search_region'] = grid_complex(packed_subgraph, ring)
    
    return region_data
    

def subgraph_neighborhood(graph, subgraph):

    # Output: subgraph induced by the given subgraph and any neighbors it has in graph

    result_nodes = set(subgraph.nodes())
    for node in subgraph.nodes():
        
        for neighbor in graph.neighbors(node):
            
            result_nodes.add(neighbor)
    
    result = graph.subgraph(result_nodes)
    
    return result



def partition_block_iterator(blocks, step_size):
    
    for count, block in enumerate(blocks):
        
        if count == 0:
            
            for i in range(1, len(block)):
                
                blocks[i] += step_size
        
        else:
            
            for i in range(len(block)):
                
                blocks[i] += step_size
    
    return
    
def name_some_vars(letters, num):
    
# Accepts a collection of strings, and an integer. Passing "U" and 3 for example returns "U0, U1, U2"
    
    result = []
    num = int(num)
    for letter in letters:
        
        for i in range(num):
            new_var = f"{letter}{i}"
            #print(new_var)
            result.append(new_var)
    
    return result

def construct_cinf(g, sigx, sigo, size = -1): 
    
    # Construct CFKinf complex from graph data - essentially just changing weights to polynomials
    # Only works for grid diagrams *not* Latin Squares

    print('constructing cinf...')
    if size == -1:
        size = len(g.get_edge_data(list(g.edges())[0][0],list(g.edges())[0][1])['diffweight'][0])  #kind of a mess - just turning the edges
        print("Grid size is " + str(size/2))
        n = size/2                                                                              #into a list and checking the length of#the weight of the first edge
    else:
        n = size
    timerstart = time.time()
    F,Vars = cinf_coeff(n)
    resG = nx.DiGraph()
    for edge in g.edges:
        
        start = edge[0]
        end = edge[1]
        poly = F(0)
        
        
        for subweight in g[edge[0]][edge[1]]['diffweight']:
            
            i = 0
            polychange = F(1)
#             print(str(subweight) + str(edge))
            for entry in subweight:
                
                polychange = polychange*(Vars[i])**entry
                i = i + 1
                
            poly += polychange
#             print(str(edge) + str(poly))
        resG.add_edge(start,end,diffweight = poly)
    
    timerend = time.time()
    elap = timerend - timerstart
    print('Time to construct cinf '+ str(elap))
    return grid_complex(resG, F, sigx, sigo)
        
    
def cinf_coeff(size):
    
    # Takes size as an argument and returns the Laurent polynomial ring over Z2 with coefficients U0,...Usize-1,V0,...Vsize-1
    
    n = size
    varis = name_some_vars(['U','V'],n)
    F = LaurentPolynomialRing(GF(2), varis)
    F.inject_variables()
  
    return F,list(F.gens())


def range_skip_entry(n, skip):
    
    # Acts similarly to standard range(n) but omits the "skip"th entry

    u = []
    for i in range(0, skip): u.append(i)
    for j in range(skip+1, n): u.append(j)       
    return u


def link_GFC(sigx, sigo, filename = None):

    # Group of usual commands/functions used to produce, simplify and output a grid_complex and
    # its simplification in one function - uses the parallel processing functions

    start_time = time.time()
    
    if filename == None:
        filename = "X"
        for pos in sigx:
            filename = filename + str(pos)
        filename = filename + "O"
        for pos in sigo:
            filename = filename + str(pos)
        filename = filename + ".gml"
    
    comp = setup_complex(sigx, sigo)

    print("passing to parallel reducer")
    comp.ego_parallel_red_search(proc_count = PROCESSOR_COUNT)
#     comp.parallel_graph_red_search(PROCESSOR_COUNT, split_key)
    print("completed parallel reducer function")
    comp.gml_export(filename)
    # picklefilename = "Pickles/edges" + filename + ".p"
    # comp.pickle_edge_dict(picklefilename)

    comp.link_normalize()
    
#     comp.parallel_graph_red_search(PROCESSOR_COUNT)
    
    filename = "Normalized" + filename
    comp.gml_export(filename)
    # picklefilename = "Pickles/edges" +filename + ".p"
    # comp.pickle_edge_dict(picklefilename)
    
    for i in range(len(comp.components)):
        comp.find_grading_ranges(f'AGrading{i}')

    end_time = time.time()

    print("Time to process complex = " + str(end_time - start_time) + " seconds")
    
    return comp



def setup_complex(sigx, sigo):

    # Takes two lists sigx and sigo, constructs and grades the associated complex then returns the result

    raw_complex = gfk.build_cinf([sigx, sigo])

    comp = construct_cinf(raw_complex, sigx, sigo)
    
    comp.grade_link_complex()

    return comp



def link_components(sigx, sigo):

    # Returns the number of components in the link defined by sigx and sigo

    xperm = pr.perm(sigx)
    operm = pr.perm(sigo)
    comps = xperm*operm**(-1)
    result = comps.cycles()
    
    return result

def link_U_deg(poly, ring, component_columns):

    # Input: poly a laurent polynomial in field a laurent polynomial ring
    #
    # Output: The total sum of powers of Ui in poly
    
    gens = ring.gens()
    size = len(gens)/2
    degree = 0
    
    if type(poly) == sage.rings.finite_rings.integer_mod.IntegerMod_int: return 0
    
    powers = poly.exponents()   
    
    # len(powers) tells you how many terms the polynomial has
#     if len(powers) > 1:
        
#         print(poly)
        
#         raise Exception("Ran into a non-homogoneous degree change - polynomial wasn't a monomial")

    if len(powers) == 0:
        
        return 0    
    
    # powers is a list of lists since its intended for more than just monomials, since we are only care about the leading
    # term we pull that one out
    powers = powers[0]
    
    for i in component_columns:
        
        degree = degree + powers[i-1]
    
    return degree


def link_V_deg(poly, ring, component_columns):

    #Input: poly a laurent polynomial in "ring" a laurent polynomial ring
    #
    #Output: The total sum of powers of Ui in poly    
    
    gens = ring.gens()
    size = len(gens)/2
    degree = 0
    
    if type(poly) == sage.rings.finite_rings.integer_mod.IntegerMod_int: return 0
    
    powers = poly.exponents()   
    
    if len(powers) == 0:
        
        return 0    
    
    # powers is a list of lists since its intended for more than just monomials, since we are only care about the leading
    # term we pull that one out

    powers = powers[0]

    for i in component_columns:
        
        degree = degree + powers[size + i-1]
    
    return degree

def parallel_active_range(max_grading_step, lower_range, upper_range, split_count):
    
    # deprecated by ego parallelization

    # Finds and returns the range of gradings that can be reduced without affecting the gluing region
    # or bleeding outside of the reserved regions

    block_size = math.floor((upper_range - lower_range)/split_count)
    
    result = block_size - 2*max_grading_step

    return result
    
    
def degree_partition(max_grading_step, lower_range, upper_range, split_count):

    # deprecated by ego parallelization

    # Returns lists marking degrees for gluing, reducing and preserving when splitting the graph
    # by grading for parallelization

    #output = list of lists
       
    if split_count == 0:
        raise Exception("Cannot split the graph into 0 pieces - check function arguments")
    
    first_round = []
    
    block_size = math.floor((upper_range - lower_range)/split_count)
    
    active_range = block_size - 2*max_grading_step
    print("active range " + str(active_range))
    
    if ((active_range <= 0) and (split_count > 1)) :
        
        print(str((max_grading_step, lower_range, upper_range, split_count - 1)))
        print("Cannot partition the graph into this many pieces! Parititioning into a smaller number of pieces")
        return degree_partition(max_grading_step, lower_range, upper_range, split_count - 1)
    
    if split_count == 1:
        
        return None
    
    block = []
    
    max_grading_step += -1
    
    trailing_edge = lower_range - 1 - max_grading_step
    leading_edge = trailing_edge 

    while trailing_edge < upper_range:
        
        block = []
        block.append(leading_edge)
        leading_edge += 1
        block.append(leading_edge)
        leading_edge += max_grading_step
        block.append(leading_edge)
        leading_edge += active_range
        block.append(leading_edge)
        leading_edge += max_grading_step
        block.append(leading_edge)
        leading_edge += 1
        block.append(leading_edge)
        first_round.append(block)
        trailing_edge = leading_edge
        
    print(first_round)
    return first_round

def alexander_grading_equivalent(comp, source, target, component_count):

    #Returns bool for if two vertices have the same Alexander multigradings

    result = True

    for i in range(component_count):
        if comp.nodes()[source][f'AGrading{i}'] != comp.nodes()[target][f'AGrading{i}']:
            result = False

    return result


#End of main code block