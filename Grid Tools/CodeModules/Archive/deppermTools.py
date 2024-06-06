#Author: Christopher St. Clair - Mathematics PhD Student at Michigan State University
#***********************************************************************
#email questions or comments to stclai ~ twenty two ~ at ~ msu dot edu
#***********************************************************************
#Adds the perm object type to work with mathematical permutation objects. Differs from lists
#and some other permutation implementations by indexing from 1 which eases some computations
#as well as being more familiar to the traditional definition of permutation groups Sn
#***********************************************************************

import numpy as np
import sys
import copy

class perm: #takes a list of integers and makes it a permutation type with standard permutation
            #group operation. Will copy argument if given a perm instead of a list datatype.

    def __init__(self, lst = [1]): #initialization just loads the list into the self.value
        check_if_valid(lst)
        if type(lst) == perm:
            self.value = lst.value.copy()
        else:
            self.value = lst.copy()

    def __str__(self):
        return str(self.value)

    def __repr__(self):
        return str(self.value)

    def __getitem__(self, i):
        return self.value[i-1]

    def __setitem__(self, i, val):
        self.value[i-1] = val

    def __mul__(self, other): #self o other as permutation composition, also loads this into the * notation so sig*phi works
        temp_sig = self.value.copy()
        temp_phi = other.value.copy()
        temp_sig, temp_phi = match_sizes(temp_sig, temp_phi)
        n = len(temp_phi)
        result = temp_sig.copy()
        for i in range(n):
            result[i] = temp_sig[temp_phi[i]-1]
        return perm(result)

    def __len__(self):
        return len(self.value)

    def __eq__(self, other): #lets us compare permutations
        if type(other) != perm:
            return False
        if self.value == other.value:
            return True
        else:
            return False

    def copy(self):
        newCopy = perm(self.value)
        return newCopy

    def inverse(self): #Finding sig^-1
        result = identity_perm(len(self.value))
        for i in range(1,len(self.value)+1):
            result[self[i]] = i
        return result

    def __pow__(self, n): #computes sig**n and loads it into the ** notation
        temp_sig, temp_id = match_sizes(self.value.copy(), [1])
        result = perm(temp_id)
        if n >= 0:
            for i in range(n):
                result = self * result
            return result
        else:
            inv = self.inverse()
            for i in range(-n):
                result = inv * result
            return result

    def size(self):
        return len(self.value)

    def cycles(self):         #returns a tuple of tuples representing the cycle notation for
        cycle_collection = [] #the given permutation for example [2, 1, 3, 5, 6, 4] --> ((1, 2)(3)(4,5,6)
        counted = []
        for x in range(self.size()):
            current = x + 1
            current_cycle = []
            while current not in counted:
                current_cycle.append(current)
                counted.append(current)
                current = self.value[current - 1]
            if len(current_cycle) > 0:
                cycle_collection.append(tuple(current_cycle))
        return tuple(cycle_collection)

    def reduce_at(self, position): #removes an element that maps to itself and renumbers the permutation so its consistent
        if self.value[position - 1] == position:
            result = []
            for x in self.value:
                if x < position:
                    result.append(x)
                elif x > position:
                    result.append(x-1)
            return perm(result)
        else:
            raise ValueError("Cannot reduce at given value - given value is not fixed under the permutation")

    def collapse_at(self, position): #pass this function the i s.t. you want to remove sigma(i)
        original_value = self.value[position - 1]
        result = []
        reference = self.value.copy()
        for x in reference:
            if x < original_value:
                result.append(x)
            elif x > original_value:
                result.append(x - 1)
        return perm(result)

    def widen_at(self, position = 1, value = 1):  #inverse of the reduce function - widens a permutation by adding i -> i in
        reference = self.value.copy()  #the middle of a permutation and renumbers the inputs and outputs that are
        size = len(reference)+1        # larger than i accordingly.
        reference.append(size)         # Ex: [1, 3, 4, 6, 2, 5] widen at 4 --> [1, 3, 5, 4, 7, 2, 6]
        result = []                    #This operation isn't very natural in permutations but it is in the context of grids
        for i in range(size):
            if i+1 < position:
                if reference[i] < value:
                    result.append(reference[i])
                else:
                    result.append(reference[i]+1)
            elif i+1 > position:
                if reference[i-1] < value:
                    result.append(reference[i-1])
                else:
                    result.append(reference[i-1]+1)
            else:
                result.append(value)
        return perm(result)

def identity_perm(n): #produces perm data type of [1, 2, 3 ... n]
    temp_list = []
    for i in range(n):
        temp_list.append(i+1)
    return perm(temp_list)

def extend_perm(sig, n, isPerm = False): #Extends a permutation to length n - will not shorten a given permutation
    check_if_valid(sig)                  #accepts lists and perms returning the same type as given
    if type(sig) == list:
        size = len(sig)
        if n <= size:
            if isPerm:
                return perm(sig)
            return sig
        extended_perm = sig
        for i in range(size+1, n+1):
            extended_perm.append(i)
        if isPerm:
            return perm(extended_perm)
        return extended_perm
    else:
        return extend_perm(sig.value, n, True)

def match_sizes(sigma, phi): #extends the sigma and phi as necessary, adding elements mapping to themselves
    check_if_valid(sigma)    #accepts lists and perms returning the same type as given
    check_if_valid(phi)
    new_sigma = perm(sigma)
    new_phi = perm(phi)
    fin_sigma = extend_perm(new_sigma, len(phi))
    fin_phi = extend_perm(new_phi, len(sigma))
    return (type(sigma)(fin_sigma.value), type(phi)(fin_phi.value))

def check_if_valid(sig): #Running collection of possible errors for given permutation arguments
    if not ((type(sig) == list) or (type(sig) == perm)): #checks if sig is a list or a perm type and raises a warning if not
        raise ValueError("Neither list nor perm passed to function")

def transposition(x, y, n = 2): #Permutation of [1,2 ... y ... x ... n] just swapping x and y
    temp_list = []
    for i in range(n):
        temp_list.append(i+1)
    temp_list[x-1] = y
    temp_list[y-1] = x
    return perm(temp_list)

def generate_all_transpositions(n):
    temp_list = []
    for x in range(1,n):
        for y in range(x+1,n+1):
            temp_list.append(transposition(x,y,n))
#            print("transposing x = " + str(x) + " and y = " + str(y))
    return temp_list

def generate_all_labeled_transpositions(n):
    temp_list = []
    for x in range(1,n):
        for y in range(x+1,n+1):
            temp_list.append([transposition(x,y,n), [x,y]])
    return temp_list

def generate_sn(n):
    ref = list(range(1,n+1))
    temp_list = []
    working_x = []
    hold = []
    for x in range(1,n+1):
        temp_list.append([x])
    for i in range(n-1):
        print(i)
        for z in range(1,n+1):
            for x in temp_list:
                if z not in x:
                    working_x = x.copy()
                    working_x.append(z)
                    hold.append(working_x)
        temp_list = hold.copy()
        hold = []
    result = []
    for entry in temp_list:
        result.append(perm(entry))
    return result


def full_cycle(n): #permutation of [1, 2, 3, ... n]
    result = []
    for i in range(n-1):
        result.append(i+2)
    result.append(1)
    return perm(result)

def perm_from_cycle(cycle, given_size = -1): #takes a TUPLE of TUPLES so make sure to include commas if either of those tuples has a single element
    size = 0              #currently broken - doesn't handled duplicate instances of an element -- requires reduced cycles
    if given_size == -1:
        for sub_cycle in cycle:
            for x in sub_cycle:
                if x > size:
                    size = x
    else:
        size = given_size
    temp_sig = []
    for i in range(size):
        temp_sig.append(i+1)
    for sub_cycle in cycle:
        for i in range(len(sub_cycle)):
            temp_sig[sub_cycle[i-1]-1] = sub_cycle[i]
    return perm(temp_sig)
