graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3, 4]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    HasBeenGraded2 1
    AGrading0 0
    UGrading0 0
    VGrading0 0
    AGrading1 0
    UGrading1 0
    VGrading1 0
    AGrading2 0
    UGrading2 0
    VGrading2 0
  ]
  node [
    id 1
    label "[2, 1, 3, 4]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    HasBeenGraded2 1
    UGrading0 1
    VGrading0 -1
    AGrading0 1
    UGrading1 -1
    VGrading1 -1
    AGrading1 0
    UGrading2 -1
    VGrading2 -1
    AGrading2 0
  ]
  node [
    id 2
    label "[1, 3, 2, 4]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    HasBeenGraded2 1
    UGrading0 -1
    VGrading0 -1
    AGrading0 0
    UGrading1 1
    VGrading1 1
    AGrading1 0
    UGrading2 -1
    VGrading2 -1
    AGrading2 0
  ]
  node [
    id 3
    label "[4, 2, 3, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    HasBeenGraded2 1
    UGrading0 -1
    VGrading0 -1
    AGrading0 0
    UGrading1 -1
    VGrading1 -1
    AGrading1 0
    UGrading2 1
    VGrading2 1
    AGrading2 0
  ]
  node [
    id 4
    label "[2, 4, 3, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    HasBeenGraded2 1
    UGrading0 0
    VGrading0 -2
    AGrading0 1
    UGrading1 -2
    VGrading1 -2
    AGrading1 0
    UGrading2 0
    VGrading2 0
    AGrading2 0
  ]
  node [
    id 5
    label "[1, 3, 4, 2]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    HasBeenGraded2 1
    UGrading0 0
    VGrading0 -2
    AGrading0 1
    UGrading1 0
    VGrading1 0
    AGrading1 0
    UGrading2 -2
    VGrading2 -2
    AGrading2 0
  ]
  node [
    id 6
    label "[4, 3, 1, 2]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    HasBeenGraded2 1
    UGrading0 -1
    VGrading0 -3
    AGrading0 1
    UGrading1 -1
    VGrading1 -1
    AGrading1 0
    UGrading2 -1
    VGrading2 -1
    AGrading2 0
  ]
  node [
    id 7
    label "[4, 3, 2, 1]"
    HasBeenGraded0 1
    HasBeenGraded1 1
    HasBeenGraded2 1
    UGrading0 -2
    VGrading0 -2
    AGrading0 0
    UGrading1 0
    VGrading1 0
    AGrading1 0
    UGrading2 0
    VGrading2 0
    AGrading2 0
  ]
  edge [
    source 0
    target 1
    diffweight "U0 + U2"
  ]
  edge [
    source 0
    target 2
    diffweight "U2*V0 + U1*V1"
  ]
  edge [
    source 0
    target 3
    diffweight "U2*V2 + U3*V3"
  ]
  edge [
    source 0
    target 6
    diffweight "U2^2*V0 + U1*U2*V1"
  ]
  edge [
    source 1
    target 0
    diffweight "V0 + V2"
  ]
  edge [
    source 1
    target 4
    diffweight "U2*V2 + U3*V3"
  ]
  edge [
    source 1
    target 7
    diffweight "U2*V0^2 + U1*V0*V1"
  ]
  edge [
    source 1
    target 5
    diffweight "U2*V0 + U1*V1"
  ]
  edge [
    source 2
    target 7
    diffweight "U0*V0 + U3*V3"
  ]
  edge [
    source 2
    target 5
    diffweight "U0 + U2"
  ]
  edge [
    source 2
    target 0
    diffweight "0"
  ]
  edge [
    source 2
    target 4
    diffweight "0"
  ]
  edge [
    source 3
    target 7
    diffweight "U2*V0 + U1*V1"
  ]
  edge [
    source 3
    target 4
    diffweight "U0 + U2"
  ]
  edge [
    source 3
    target 0
    diffweight "0"
  ]
  edge [
    source 3
    target 5
    diffweight "0"
  ]
  edge [
    source 4
    target 3
    diffweight "V0 + V2"
  ]
  edge [
    source 4
    target 1
    diffweight "0"
  ]
  edge [
    source 4
    target 6
    diffweight "U2*V0 + U1*V1"
  ]
  edge [
    source 5
    target 2
    diffweight "V0 + V2"
  ]
  edge [
    source 5
    target 6
    diffweight "U0*V0 + U3*V3"
  ]
  edge [
    source 5
    target 1
    diffweight "0"
  ]
  edge [
    source 5
    target 3
    diffweight "0"
  ]
  edge [
    source 6
    target 7
    diffweight "V0 + V2"
  ]
  edge [
    source 6
    target 5
    diffweight "0"
  ]
  edge [
    source 6
    target 4
    diffweight "0"
  ]
  edge [
    source 7
    target 3
    diffweight "0"
  ]
  edge [
    source 7
    target 6
    diffweight "U0 + U2"
  ]
  edge [
    source 7
    target 2
    diffweight "0"
  ]
]
