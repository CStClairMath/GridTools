graph [
  directed 1
  node [
    id 0
    label "[4, 2, 3, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -1
    AGrading0 0
    UGrading1 -1
    VGrading1 -1
    AGrading1 2
  ]
  node [
    id 1
    label "[2, 1, 4, 3]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 0
    VGrading0 -2
    AGrading0 3
    UGrading1 -2
    VGrading1 -2
    AGrading1 0
  ]
  node [
    id 2
    label "[2, 4, 3, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -2
    VGrading0 -2
    AGrading0 2
    UGrading1 -2
    VGrading1 -2
    AGrading1 2
  ]
  node [
    id 3
    label "[4, 2, 1, 3]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -2
    VGrading0 -2
    AGrading0 2
    UGrading1 -2
    VGrading1 -2
    AGrading1 2
  ]
  node [
    id 4
    label "[2, 4, 1, 3]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -3
    AGrading0 3
    UGrading1 -3
    VGrading1 -3
    AGrading1 2
  ]
  node [
    id 5
    label "[3, 1, 4, 2]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -3
    AGrading0 3
    UGrading1 -3
    VGrading1 -3
    AGrading1 2
  ]
  node [
    id 6
    label "[3, 4, 2, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -3
    VGrading0 -3
    AGrading0 2
    UGrading1 -1
    VGrading1 -3
    AGrading1 3
  ]
  node [
    id 7
    label "[4, 3, 2, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -2
    VGrading0 -2
    AGrading0 0
    UGrading1 0
    VGrading1 -2
    AGrading1 3
  ]
  edge [
    source 2
    target 4
    diffweight "U0 + U1"
  ]
  edge [
    source 2
    target 5
    diffweight "U0 + U1"
  ]
  edge [
    source 3
    target 0
    diffweight "U0 + U1"
  ]
  edge [
    source 4
    target 1
    diffweight "U0 + U1"
  ]
  edge [
    source 5
    target 1
    diffweight "U0 + U1"
  ]
  edge [
    source 6
    target 7
    diffweight "U0 + U1"
  ]
]
