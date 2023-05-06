graph [
  directed 1
  node [
    id 0
    label "[4, 1, 5, 2, 3]"
    HasBeenGraded 1
    UGrading 0
    VGrading 0
    AGrading 0
  ]
  node [
    id 1
    label "[5, 3, 1, 2, 4]"
    HasBeenGraded 1
    UGrading -1
    VGrading 1
    AGrading -1
  ]
  node [
    id 2
    label "[5, 4, 1, 2, 3]"
    HasBeenGraded 1
    UGrading 0
    VGrading 2
    AGrading -1
  ]
  node [
    id 3
    label "[4, 5, 1, 2, 3]"
    HasBeenGraded 1
    UGrading 1
    VGrading 1
    AGrading 0
  ]
  node [
    id 4
    label "[4, 5, 2, 1, 3]"
    HasBeenGraded 1
    UGrading 0
    VGrading 0
    AGrading 0
  ]
  node [
    id 5
    label "[1, 5, 3, 2, 4]"
    HasBeenGraded 1
    UGrading -1
    VGrading 1
    AGrading -1
  ]
  edge [
    source 0
    target 3
    diffweight "U0"
  ]
  edge [
    source 2
    target 3
    diffweight "U0"
  ]
  edge [
    source 4
    target 3
    diffweight "U0"
  ]
]
