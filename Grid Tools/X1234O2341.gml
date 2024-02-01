graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3, 4]"
    HasBeenGraded0 1
    AGrading0 0
    UGrading0 0
    VGrading0 0
  ]
  node [
    id 1
    label "[2, 1, 3, 4]"
    HasBeenGraded0 1
    UGrading0 -1
    VGrading0 -1
    AGrading0 0
  ]
  node [
    id 2
    label "[1, 3, 2, 4]"
    HasBeenGraded0 1
    UGrading0 1
    VGrading0 -1
    AGrading0 1
  ]
  node [
    id 3
    label "[4, 2, 3, 1]"
    HasBeenGraded0 1
    UGrading0 1
    VGrading0 -1
    AGrading0 1
  ]
  node [
    id 4
    label "[2, 3, 1, 4]"
    HasBeenGraded0 1
    UGrading0 0
    VGrading0 -2
    AGrading0 1
  ]
  node [
    id 5
    label "[2, 4, 3, 1]"
    HasBeenGraded0 1
    UGrading0 0
    VGrading0 -2
    AGrading0 1
  ]
  node [
    id 6
    label "[3, 2, 4, 1]"
    HasBeenGraded0 1
    UGrading0 2
    VGrading0 -2
    AGrading0 2
  ]
  node [
    id 7
    label "[2, 3, 4, 1]"
    HasBeenGraded0 1
    UGrading0 1
    VGrading0 -3
    AGrading0 2
  ]
  edge [
    source 0
    target 1
    diffweight "U0 + U2"
  ]
  edge [
    source 0
    target 2
    diffweight "U1 + U2"
  ]
  edge [
    source 0
    target 3
    diffweight "U2 + U3"
  ]
  edge [
    source 1
    target 4
    diffweight "U1 + U2"
  ]
  edge [
    source 1
    target 0
    diffweight "V0 + V3"
  ]
  edge [
    source 1
    target 5
    diffweight "U2 + U3"
  ]
  edge [
    source 2
    target 0
    diffweight "V0 + V1"
  ]
  edge [
    source 2
    target 4
    diffweight "U0 + U2"
  ]
  edge [
    source 2
    target 6
    diffweight "U2 + U3"
  ]
  edge [
    source 2
    target 5
    diffweight "U2 + U3"
  ]
  edge [
    source 3
    target 5
    diffweight "U0 + U1"
  ]
  edge [
    source 3
    target 0
    diffweight "V2 + V3"
  ]
  edge [
    source 3
    target 6
    diffweight "U1 + U2"
  ]
  edge [
    source 4
    target 1
    diffweight "V0 + V1"
  ]
  edge [
    source 4
    target 7
    diffweight "U2 + U3"
  ]
  edge [
    source 4
    target 2
    diffweight "V0 + V3"
  ]
  edge [
    source 5
    target 3
    diffweight "V0 + V3"
  ]
  edge [
    source 5
    target 7
    diffweight "U1 + U2"
  ]
  edge [
    source 5
    target 1
    diffweight "V2 + V3"
  ]
  edge [
    source 6
    target 7
    diffweight "U0 + U1"
  ]
  edge [
    source 6
    target 3
    diffweight "V1 + V3"
  ]
  edge [
    source 6
    target 2
    diffweight "V2 + V3"
  ]
  edge [
    source 6
    target 1
    diffweight "V2 + V3"
  ]
  edge [
    source 7
    target 6
    diffweight "V0 + V3"
  ]
  edge [
    source 7
    target 5
    diffweight "V1 + V3"
  ]
  edge [
    source 7
    target 4
    diffweight "V2 + V3"
  ]
]
