graph [
  directed 1
  node [
    id 0
    label "[1, 2]"
    HasBeenGraded0 1
    AGrading0 0
    UGrading0 0
    VGrading0 0
  ]
  node [
    id 1
    label "[2, 1]"
    HasBeenGraded0 1
    UGrading0 -1
    VGrading0 -1
    AGrading0 0
  ]
  edge [
    source 0
    target 1
    diffweight "U0 + U1"
  ]
  edge [
    source 1
    target 0
    diffweight "V0 + V1"
  ]
]
