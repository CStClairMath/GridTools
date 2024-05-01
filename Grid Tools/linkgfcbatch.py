from CodeModules.cinfprocessing import *
import GFKTools as gfk

import sys

index = int(sys.argv[1])

link_partition = gfk.imp_from_pickle(f"./Pickles/size_8_batch_{index}")

for entry in link_partition:
    link = entry[0]
    perms = entry[1]
    reduced_comp = link_GFC(*perms, link)

