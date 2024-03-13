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
    label "[2, 1, 3, 4]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -1
    AGrading0 0
    UGrading1 -1
    VGrading1 -1
    AGrading1 0
  ]
  node [
    id 2
    label "[1, 3, 2, 4]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 1
    VGrading0 -1
    AGrading0 1
    UGrading1 -1
    VGrading1 -1
    AGrading1 0
  ]
  node [
    id 3
    label "[1, 2, 4, 3]"
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
    id 4
    label "[4, 2, 3, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 1
    VGrading0 -1
    AGrading0 1
    UGrading1 -1
    VGrading1 -1
    AGrading1 0
  ]
  node [
    id 5
    label "[2, 1, 4, 3]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -2
    VGrading0 -2
    AGrading0 0
    UGrading1 0
    VGrading1 -2
    AGrading1 1
  ]
  node [
    id 6
    label "[3, 1, 2, 4]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 0
    VGrading0 -2
    AGrading0 1
    UGrading1 -2
    VGrading1 -2
    AGrading1 0
  ]
  node [
    id 7
    label "[2, 4, 3, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 0
    VGrading0 -2
    AGrading0 1
    UGrading1 -2
    VGrading1 -2
    AGrading1 0
  ]
  node [
    id 8
    label "[1, 3, 4, 2]"
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
    id 9
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
    id 10
    label "[2, 4, 1, 3]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -3
    AGrading0 1
    UGrading1 -1
    VGrading1 -3
    AGrading1 1
  ]
  node [
    id 11
    label "[3, 1, 4, 2]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 -1
    VGrading0 -3
    AGrading0 1
    UGrading1 -1
    VGrading1 -3
    AGrading1 1
  ]
  node [
    id 12
    label "[3, 4, 2, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 1
    VGrading0 -3
    AGrading0 2
    UGrading1 -3
    VGrading1 -3
    AGrading1 0
  ]
  node [
    id 13
    label "[4, 3, 1, 2]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 1
    VGrading0 -3
    AGrading0 2
    UGrading1 -3
    VGrading1 -3
    AGrading1 0
  ]
  node [
    id 14
    label "[3, 4, 1, 2]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 0
    VGrading0 -4
    AGrading0 2
    UGrading1 -2
    VGrading1 -4
    AGrading1 1
  ]
  node [
    id 15
    label "[4, 3, 2, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    UGrading0 2
    VGrading0 -2
    AGrading0 2
    UGrading1 -2
    VGrading1 -2
    AGrading1 0
  ]
  edge [
    source 0
    target 1
    diffweight "U0"
  ]
  edge [
    source 0
    target 2
    diffweight "U1"
  ]
  edge [
    source 0
    target 3
    diffweight "U0"
  ]
  edge [
    source 0
    target 4
    diffweight "U1"
  ]
  edge [
    source 1
    target 5
    diffweight "U0"
  ]
  edge [
    source 1
    target 6
    diffweight "U1"
  ]
  edge [
    source 1
    target 7
    diffweight "U1"
  ]
  edge [
    source 2
    target 15
    diffweight "U1"
  ]
  edge [
    source 2
    target 8
    diffweight "U0"
  ]
  edge [
    source 2
    target 9
    diffweight "U0"
  ]
  edge [
    source 3
    target 5
    diffweight "U0"
  ]
  edge [
    source 3
    target 6
    diffweight "U1"
  ]
  edge [
    source 3
    target 7
    diffweight "U1"
  ]
  edge [
    source 4
    target 15
    diffweight "U1"
  ]
  edge [
    source 4
    target 9
    diffweight "U0"
  ]
  edge [
    source 4
    target 8
    diffweight "U0"
  ]
  edge [
    source 6
    target 11
    diffweight "U0"
  ]
  edge [
    source 6
    target 12
    diffweight "U1"
  ]
  edge [
    source 6
    target 13
    diffweight "U1"
  ]
  edge [
    source 6
    target 10
    diffweight "U0"
  ]
  edge [
    source 7
    target 10
    diffweight "U0"
  ]
  edge [
    source 7
    target 12
    diffweight "U1"
  ]
  edge [
    source 7
    target 13
    diffweight "U1"
  ]
  edge [
    source 7
    target 11
    diffweight "U0"
  ]
  edge [
    source 8
    target 2
    diffweight "1"
  ]
  edge [
    source 8
    target 3
    diffweight "1"
  ]
  edge [
    source 8
    target 1
    diffweight "1"
  ]
  edge [
    source 8
    target 4
    diffweight "1"
  ]
  edge [
    source 9
    target 4
    diffweight "1"
  ]
  edge [
    source 9
    target 3
    diffweight "1"
  ]
  edge [
    source 9
    target 1
    diffweight "1"
  ]
  edge [
    source 9
    target 2
    diffweight "1"
  ]
  edge [
    source 10
    target 5
    diffweight "1"
  ]
  edge [
    source 10
    target 7
    diffweight "1"
  ]
  edge [
    source 10
    target 6
    diffweight "1"
  ]
  edge [
    source 11
    target 5
    diffweight "1"
  ]
  edge [
    source 11
    target 6
    diffweight "1"
  ]
  edge [
    source 11
    target 7
    diffweight "1"
  ]
  edge [
    source 12
    target 15
    diffweight "1"
  ]
  edge [
    source 12
    target 9
    diffweight "1"
  ]
  edge [
    source 12
    target 8
    diffweight "1"
  ]
  edge [
    source 13
    target 15
    diffweight "1"
  ]
  edge [
    source 13
    target 8
    diffweight "1"
  ]
  edge [
    source 13
    target 9
    diffweight "1"
  ]
  edge [
    source 14
    target 13
    diffweight "1"
  ]
  edge [
    source 14
    target 11
    diffweight "1"
  ]
  edge [
    source 14
    target 12
    diffweight "1"
  ]
  edge [
    source 14
    target 10
    diffweight "1"
  ]
]
