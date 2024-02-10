graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3, 4]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    AGrading0 0
    UGrading0 0
    VGrading0 0
    AGrading1 0
    UGrading1 0
    VGrading1 0
  ]
  node [
    id 1
    label "[4, 2, 3, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -1
    AGrading0 0
    UGrading1 1
    VGrading1 -1
    AGrading1 1
  ]
  node [
    id 2
    label "[2, 4, 3, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 0
    VGrading0 -2
    AGrading0 1
    UGrading1 0
    VGrading1 -2
    AGrading1 1
  ]
  node [
    id 3
    label "[4, 2, 1, 3]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 0
    VGrading0 -2
    AGrading0 1
    UGrading1 0
    VGrading1 -2
    AGrading1 1
  ]
  node [
    id 4
    label "[2, 4, 1, 3]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -3
    AGrading0 3
    UGrading1 -1
    VGrading1 -3
    AGrading1 1
  ]
  node [
    id 5
    label "[3, 4, 2, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -3
    AGrading0 1
    UGrading1 -1
    VGrading1 -3
    AGrading1 3
  ]
  node [
    id 6
    label "[4, 3, 1, 2]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -3
    AGrading0 1
    UGrading1 -1
    VGrading1 -3
    AGrading1 3
  ]
  node [
    id 7
    label "[3, 4, 1, 2]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -2
    VGrading0 -4
    AGrading0 3
    UGrading1 -2
    VGrading1 -4
    AGrading1 3
  ]
  edge [
    source 0
    target 1
    diffweight "U0 + U1"
  ]
  edge [
    source 4
    target 2
    diffweight "U0 + U1"
  ]
  edge [
    source 5
    target 3
    diffweight "U0 + U1"
  ]
  edge [
    source 6
    target 3
    diffweight "U0 + U1"
  ]
  edge [
    source 7
    target 6
    diffweight "U0 + U1"
  ]
  edge [
    source 7
    target 5
    diffweight "U0 + U1"
  ]
]
