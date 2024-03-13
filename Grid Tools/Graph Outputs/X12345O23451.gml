graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3, 5, 4]"
    HasBeenGraded0 1
    UGrading0 1
    VGrading0 -1
    HasBeenGraded 1
    UGrading 1
    VGrading 1
    AGrading0 -3
  ]
  node [
    id 1
    label "[2, 1, 3, 5, 4]"
    HasBeenGraded0 1
    UGrading0 2
    VGrading0 -2
    HasBeenGraded 1
    UGrading 2
    VGrading 2
    AGrading0 -4
  ]
  node [
    id 2
    label "[1, 3, 2, 5, 4]"
    HasBeenGraded0 1
    UGrading0 2
    VGrading0 -2
    HasBeenGraded 1
    UGrading 2
    VGrading 2
    AGrading0 -4
  ]
  node [
    id 3
    label "[4, 2, 3, 5, 1]"
    HasBeenGraded0 1
    UGrading0 2
    VGrading0 -2
    HasBeenGraded 1
    UGrading 2
    VGrading 2
    AGrading0 -4
  ]
  node [
    id 4
    label "[1, 2, 3, 4, 5]"
    HasBeenGraded0 1
    AGrading0 -2
    UGrading0 0
    VGrading0 0
    HasBeenGraded 1
    UGrading 0
    VGrading 0
  ]
  node [
    id 5
    label "[2, 1, 3, 4, 5]"
    HasBeenGraded0 1
    UGrading0 1
    VGrading0 -1
    HasBeenGraded 1
    UGrading 1
    VGrading 1
    AGrading0 -3
  ]
  node [
    id 6
    label "[2, 4, 3, 5, 1]"
    HasBeenGraded0 1
    UGrading0 3
    VGrading0 -3
    HasBeenGraded 1
    UGrading 3
    VGrading 3
    AGrading0 -5
  ]
  node [
    id 7
    label "[1, 2, 4, 3, 5]"
    HasBeenGraded0 1
    UGrading0 1
    VGrading0 -1
    HasBeenGraded 1
    UGrading 1
    VGrading 1
    AGrading0 -3
  ]
  node [
    id 8
    label "[5, 2, 3, 4, 1]"
    HasBeenGraded0 1
    UGrading0 1
    VGrading0 -1
    HasBeenGraded 1
    UGrading 1
    VGrading 1
    AGrading0 -3
  ]
  node [
    id 9
    label "[2, 3, 1, 4, 5]"
    HasBeenGraded0 1
    UGrading0 2
    VGrading0 -2
    HasBeenGraded 1
    UGrading 2
    VGrading 2
    AGrading0 -4
  ]
  node [
    id 10
    label "[3, 2, 4, 5, 1]"
    HasBeenGraded0 1
    UGrading0 3
    VGrading0 -3
    HasBeenGraded 1
    UGrading 3
    VGrading 3
    AGrading0 -5
  ]
  node [
    id 11
    label "[2, 3, 4, 5, 1]"
    HasBeenGraded0 1
    UGrading0 4
    VGrading0 -4
    HasBeenGraded 1
    UGrading 4
    VGrading 4
    AGrading0 -6
  ]
  node [
    id 12
    label "[2, 3, 4, 1, 5]"
    HasBeenGraded0 1
    UGrading0 3
    VGrading0 -3
    HasBeenGraded 1
    UGrading 3
    VGrading 3
    AGrading0 -5
  ]
  node [
    id 13
    label "[2, 3, 5, 4, 1]"
    HasBeenGraded0 1
    UGrading0 3
    VGrading0 -3
    HasBeenGraded 1
    UGrading 3
    VGrading 3
    AGrading0 -5
  ]
  node [
    id 14
    label "[3, 2, 4, 1, 5]"
    HasBeenGraded0 1
    UGrading0 2
    VGrading0 -2
    HasBeenGraded 1
    UGrading 2
    VGrading 2
    AGrading0 -4
  ]
  node [
    id 15
    label "[2, 4, 3, 1, 5]"
    HasBeenGraded0 1
    UGrading0 2
    VGrading0 -2
    HasBeenGraded 1
    UGrading 2
    VGrading 2
    AGrading0 -4
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
    diffweight "U2 + U4"
  ]
  edge [
    source 0
    target 4
    diffweight "V2 + V3"
  ]
  edge [
    source 1
    target 0
    diffweight "V0 + V4"
  ]
  edge [
    source 1
    target 5
    diffweight "V2 + V3"
  ]
  edge [
    source 1
    target 6
    diffweight "U2 + U4"
  ]
  edge [
    source 1
    target 13
    diffweight "U1 + U2"
  ]
  edge [
    source 1
    target 12
    diffweight "U1 + U2"
  ]
  edge [
    source 2
    target 0
    diffweight "V0 + V1 + V2 + V3"
  ]
  edge [
    source 2
    target 10
    diffweight "U2 + U4"
  ]
  edge [
    source 2
    target 6
    diffweight "U2 + U4"
  ]
  edge [
    source 2
    target 7
    diffweight "V2 + V3"
  ]
  edge [
    source 2
    target 5
    diffweight "V2 + V3"
  ]
  edge [
    source 2
    target 8
    diffweight "V2 + V3"
  ]
  edge [
    source 2
    target 13
    diffweight "U0 + U2"
  ]
  edge [
    source 2
    target 12
    diffweight "U0 + U2"
  ]
  edge [
    source 3
    target 6
    diffweight "U0 + U1"
  ]
  edge [
    source 3
    target 0
    diffweight "V3 + V4"
  ]
  edge [
    source 3
    target 8
    diffweight "V2 + V3"
  ]
  edge [
    source 3
    target 10
    diffweight "U1 + U2"
  ]
  edge [
    source 4
    target 5
    diffweight "U0 + U1"
  ]
  edge [
    source 4
    target 7
    diffweight "U1 + U2"
  ]
  edge [
    source 4
    target 0
    diffweight "U1 + U3"
  ]
  edge [
    source 4
    target 8
    diffweight "U1 + U4"
  ]
  edge [
    source 5
    target 1
    diffweight "U3 + U4"
  ]
  edge [
    source 5
    target 9
    diffweight "U1 + U2"
  ]
  edge [
    source 5
    target 4
    diffweight "V0 + V4"
  ]
  edge [
    source 5
    target 15
    diffweight "U2 + U4"
  ]
  edge [
    source 6
    target 15
    diffweight "V2 + V3"
  ]
  edge [
    source 6
    target 3
    diffweight "V0 + V4"
  ]
  edge [
    source 6
    target 11
    diffweight "U1 + U2"
  ]
  edge [
    source 6
    target 1
    diffweight "V2 + V4"
  ]
  edge [
    source 7
    target 4
    diffweight "V1 + V2"
  ]
  edge [
    source 7
    target 2
    diffweight "U3 + U4"
  ]
  edge [
    source 7
    target 1
    diffweight "U3 + U4"
  ]
  edge [
    source 7
    target 3
    diffweight "U3 + U4"
  ]
  edge [
    source 7
    target 14
    diffweight "U1 + U4"
  ]
  edge [
    source 7
    target 15
    diffweight "U0 + U1"
  ]
  edge [
    source 7
    target 9
    diffweight "U0 + U1"
  ]
  edge [
    source 8
    target 4
    diffweight "V3 + V4"
  ]
  edge [
    source 8
    target 3
    diffweight "U2 + U3"
  ]
  edge [
    source 8
    target 1
    diffweight "U0 + U2"
  ]
  edge [
    source 8
    target 15
    diffweight "U0 + U1"
  ]
  edge [
    source 8
    target 14
    diffweight "U1 + U2"
  ]
  edge [
    source 8
    target 2
    diffweight "U1 + U2"
  ]
  edge [
    source 9
    target 5
    diffweight "V1 + V4"
  ]
  edge [
    source 9
    target 12
    diffweight "U2 + U3"
  ]
  edge [
    source 9
    target 13
    diffweight "U3 + U4"
  ]
  edge [
    source 9
    target 0
    diffweight "V0 + V4"
  ]
  edge [
    source 9
    target 7
    diffweight "V0 + V4"
  ]
  edge [
    source 9
    target 8
    diffweight "V0 + V4"
  ]
  edge [
    source 10
    target 14
    diffweight "V2 + V3"
  ]
  edge [
    source 10
    target 11
    diffweight "U0 + U1"
  ]
  edge [
    source 10
    target 3
    diffweight "V1 + V4"
  ]
  edge [
    source 10
    target 2
    diffweight "V2 + V4"
  ]
  edge [
    source 10
    target 1
    diffweight "V2 + V4"
  ]
  edge [
    source 11
    target 10
    diffweight "V0 + V4"
  ]
  edge [
    source 11
    target 6
    diffweight "V1 + V4"
  ]
  edge [
    source 11
    target 13
    diffweight "V2 + V4"
  ]
  edge [
    source 11
    target 12
    diffweight "V3 + V4"
  ]
  edge [
    source 12
    target 14
    diffweight "V0 + V4"
  ]
  edge [
    source 12
    target 15
    diffweight "V1 + V4"
  ]
  edge [
    source 12
    target 9
    diffweight "V2 + V4"
  ]
  edge [
    source 12
    target 11
    diffweight "U3 + U4"
  ]
  edge [
    source 13
    target 11
    diffweight "U2 + U3"
  ]
  edge [
    source 13
    target 9
    diffweight "V3 + V4"
  ]
  edge [
    source 13
    target 1
    diffweight "V0 + V1"
  ]
  edge [
    source 13
    target 15
    diffweight "V1 + V4"
  ]
  edge [
    source 13
    target 3
    diffweight "0"
  ]
  edge [
    source 13
    target 14
    diffweight "V0 + V4"
  ]
  edge [
    source 13
    target 2
    diffweight "V0 + V4"
  ]
  edge [
    source 14
    target 12
    diffweight "U0 + U1"
  ]
  edge [
    source 14
    target 10
    diffweight "U3 + U4"
  ]
  edge [
    source 14
    target 7
    diffweight "V2 + V4"
  ]
  edge [
    source 14
    target 8
    diffweight "V1 + V2"
  ]
  edge [
    source 14
    target 0
    diffweight "V1 + V2"
  ]
  edge [
    source 14
    target 5
    diffweight "0"
  ]
  edge [
    source 15
    target 12
    diffweight "U1 + U2"
  ]
  edge [
    source 15
    target 6
    diffweight "U3 + U4"
  ]
  edge [
    source 15
    target 5
    diffweight "V2 + V4"
  ]
  edge [
    source 15
    target 8
    diffweight "V0 + V4"
  ]
  edge [
    source 15
    target 0
    diffweight "V0 + V4"
  ]
  edge [
    source 15
    target 7
    diffweight "0"
  ]
]
