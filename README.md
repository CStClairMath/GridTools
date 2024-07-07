# Grid Complex Program
 
The collection of programs here are in support of my dissertation, A Program to Compute Combinatorial Multifiltered Link Floer Complexes. It is broadly made of two core component programs, GFKTools.py and cinfprocessing.sage. GFKTools produces all data necessary for the infinity flavor of the grid complex and loads it into a networkx directed graph but doesn't package it in a particularly readable or functional formaat. The second program, cinfprocessing.sage is sage code that converts the data into polynomial edgeweights, implements a standard reduction/simplification algorithm along with a variety of other useful functions. 

The functionality has been exported from the Sage code to a Python file, but the workflow in practice is to run the Sage code in a Jupyter notebook.

**Warning!!** This code works and is confirmed for Sagemath 10.2, the final version supporting Windows was 9.3 and has a bug in some supporting functions that causes erroneous results. As such it should *not* be used.
