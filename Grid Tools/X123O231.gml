graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3]"
    HasBeenGraded0 1
    AGrading0 0
    UGrading0 0
    VGrading0 0
  ]
  node [
    id 1
    label "[2, 1, 3]"
    HasBeenGraded0 1
    UGrading0 -1
    VGrading0 -1
    AGrading0 0
  ]
  node [
    id 2
    label "[3, 2, 1]"
    HasBeenGraded0 1
    UGrading0 1
    VGrading0 -1
    AGrading0 1
  ]
  node [
    id 3
    label "[2, 3, 1]"
    HasBeenGraded0 1
    UGrading0 0
    VGrading0 -2
    AGrading0 1
  ]
  edge [
    source 0
    target 1
    diffweight "U0 + U1"
  ]
  edge [
    source 0
    target 2
    diffweight "U1 + U2"
  ]
  edge [
    source 1
    target 0
    diffweight "V0 + V2"
  ]
  edge [
    source 1
    target 3
    diffweight "U1 + U2"
  ]
  edge [
    source 2
    target 3
    diffweight "U0 + U1"
  ]
  edge [
    source 2
    target 0
    diffweight "V1 + V2"
  ]
  edge [
    source 3
    target 2
    diffweight "V0 + V2"
  ]
  edge [
    source 3
    target 1
    diffweight "V1 + V2"
  ]
]
