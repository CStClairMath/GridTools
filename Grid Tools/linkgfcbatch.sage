from CodeModules.cinfprocessing import *
import CodeModules.GFKTools as gfk

import sys

index = sys.argv[1]

link_dict_partition = gfk.imp_from_pickle(f"./Pickles/sub_dict{index}.pickle")

for link in link_dict_partition:
    if len(link_dict_partition[link][0]) < 9:
        reduced_comp = link_GFC(*link_dict_partition[link], link)
        gfk.pickle_it(reduced_comp, link + ".pickle")
