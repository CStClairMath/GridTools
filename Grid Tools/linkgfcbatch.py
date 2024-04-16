from CodeModules.cinfprocessing import *

import sys

index = sys.argv[1]

link_dict_partition = gfk.imp_from_pickle("partitioned_link_dict.pickle")

for link in link_dict_partition[f"sub_dict{index}"]:

    link_GFC(*link_dict_partition[f"sub_dict{index}"][link], link)
