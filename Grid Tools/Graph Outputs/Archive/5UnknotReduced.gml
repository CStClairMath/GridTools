graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3, 5, 4]"
    HasBeenGraded 1
    AGrading 0
    UGrading 0
    VGrading 0
  ]
  node [
    id 1
    label "[1, 2, 3, 4, 5]"
    HasBeenGraded 1
    UGrading -1
    VGrading 1
    AGrading -1
  ]
  node [
    id 2
    label "[2, 1, 3, 4, 5]"
    HasBeenGraded 1
    UGrading 0
    VGrading 0
    AGrading 0
  ]
  node [
    id 3
    label "[2, 4, 3, 5, 1]"
    HasBeenGraded 1
    UGrading 2
    VGrading -2
    AGrading 2
  ]
  node [
    id 4
    label "[1, 2, 4, 3, 5]"
    HasBeenGraded 1
    UGrading 0
    VGrading 0
    AGrading 0
  ]
  node [
    id 5
    label "[3, 2, 4, 5, 1]"
    HasBeenGraded 1
    UGrading 2
    VGrading -2
    AGrading 2
  ]
  node [
    id 6
    label "[2, 3, 4, 5, 1]"
    HasBeenGraded 1
    UGrading 3
    VGrading -3
    AGrading 3
  ]
  node [
    id 7
    label "[2, 3, 4, 1, 5]"
    HasBeenGraded 1
    UGrading 2
    VGrading -2
    AGrading 2
  ]
  node [
    id 8
    label "[3, 2, 5, 4, 1]"
    HasBeenGraded 1
    UGrading 1
    VGrading -1
    AGrading 1
  ]
  node [
    id 9
    label "[5, 1, 2, 4, 3]"
    HasBeenGraded 1
    UGrading 2
    VGrading 2
    AGrading 0
  ]
  node [
    id 10
    label "[2, 3, 5, 4, 1]"
    HasBeenGraded 1
    UGrading 2
    VGrading -2
    AGrading 2
  ]
  node [
    id 11
    label "[2, 5, 1, 3, 4]"
    HasBeenGraded 1
    UGrading 3
    VGrading 1
    AGrading 1
  ]
  node [
    id 12
    label "[3, 2, 4, 1, 5]"
    HasBeenGraded 1
    UGrading 1
    VGrading -1
    AGrading 1
  ]
  node [
    id 13
    label "[2, 4, 3, 1, 5]"
    HasBeenGraded 1
    UGrading 1
    VGrading -1
    AGrading 1
  ]
  node [
    id 14
    label "[3, 4, 1, 2, 5]"
    HasBeenGraded 1
    UGrading 3
    VGrading 1
    AGrading 1
  ]
  node [
    id 15
    label "[3, 5, 1, 4, 2]"
    HasBeenGraded 1
    UGrading 3
    VGrading 1
    AGrading 1
  ]
  edge [
    source 0
    target 1
    diffweight "V2"
  ]
  edge [
    source 0
    target 8
    diffweight "U2"
  ]
  edge [
    source 0
    target 12
    diffweight "U2"
  ]
  edge [
    source 0
    target 11
    diffweight "U2*U4*V3"
  ]
  edge [
    source 0
    target 14
    diffweight "U2*U4*V3"
  ]
  edge [
    source 0
    target 13
    diffweight "U2"
  ]
  edge [
    source 0
    target 15
    diffweight "U2*U4*V3"
  ]
  edge [
    source 1
    target 2
    diffweight "U1"
  ]
  edge [
    source 1
    target 4
    diffweight "U1"
  ]
  edge [
    source 1
    target 0
    diffweight "U1"
  ]
  edge [
    source 1
    target 9
    diffweight "U1*U4*V3"
  ]
  edge [
    source 2
    target 1
    diffweight "V4"
  ]
  edge [
    source 2
    target 11
    diffweight "U2*U4*V4"
  ]
  edge [
    source 2
    target 13
    diffweight "U2"
  ]
  edge [
    source 2
    target 14
    diffweight "U2*U4*V4"
  ]
  edge [
    source 2
    target 15
    diffweight "U2*U4*V4"
  ]
  edge [
    source 2
    target 8
    diffweight "U2"
  ]
  edge [
    source 3
    target 13
    diffweight "V4"
  ]
  edge [
    source 3
    target 6
    diffweight "U2"
  ]
  edge [
    source 3
    target 11
    diffweight "U4*V3*V4"
  ]
  edge [
    source 3
    target 8
    diffweight "V4"
  ]
  edge [
    source 3
    target 12
    diffweight "V4"
  ]
  edge [
    source 3
    target 14
    diffweight "U4*V3*V4"
  ]
  edge [
    source 3
    target 15
    diffweight "U4*V3*V4"
  ]
  edge [
    source 4
    target 1
    diffweight "V1"
  ]
  edge [
    source 4
    target 12
    diffweight "U4"
  ]
  edge [
    source 4
    target 13
    diffweight "U4"
  ]
  edge [
    source 4
    target 14
    diffweight "U4^2*V3"
  ]
  edge [
    source 4
    target 11
    diffweight "U4^2*V3"
  ]
  edge [
    source 4
    target 15
    diffweight "U4^2*V3"
  ]
  edge [
    source 4
    target 8
    diffweight "U4"
  ]
  edge [
    source 5
    target 8
    diffweight "V4"
  ]
  edge [
    source 5
    target 12
    diffweight "V4"
  ]
  edge [
    source 5
    target 6
    diffweight "U1"
  ]
  edge [
    source 5
    target 11
    diffweight "U4*V3*V4"
  ]
  edge [
    source 5
    target 14
    diffweight "U4*V3*V4"
  ]
  edge [
    source 5
    target 13
    diffweight "V4"
  ]
  edge [
    source 5
    target 15
    diffweight "U4*V3*V4"
  ]
  edge [
    source 6
    target 5
    diffweight "V4"
  ]
  edge [
    source 6
    target 3
    diffweight "V4"
  ]
  edge [
    source 6
    target 10
    diffweight "V4"
  ]
  edge [
    source 6
    target 7
    diffweight "V4"
  ]
  edge [
    source 6
    target 9
    diffweight "V0*V2*V4"
  ]
  edge [
    source 7
    target 12
    diffweight "V4"
  ]
  edge [
    source 7
    target 13
    diffweight "V4"
  ]
  edge [
    source 7
    target 6
    diffweight "U4"
  ]
  edge [
    source 7
    target 14
    diffweight "U4*V4^2"
  ]
  edge [
    source 7
    target 11
    diffweight "U4*V4^2"
  ]
  edge [
    source 7
    target 15
    diffweight "U4*V4^2"
  ]
  edge [
    source 7
    target 8
    diffweight "V4"
  ]
  edge [
    source 8
    target 10
    diffweight "U1"
  ]
  edge [
    source 8
    target 5
    diffweight "U3"
  ]
  edge [
    source 8
    target 0
    diffweight "V3"
  ]
  edge [
    source 8
    target 4
    diffweight "V3"
  ]
  edge [
    source 8
    target 9
    diffweight "U4*V3^2"
  ]
  edge [
    source 8
    target 2
    diffweight "V3"
  ]
  edge [
    source 10
    target 8
    diffweight "V4"
  ]
  edge [
    source 10
    target 6
    diffweight "U3"
  ]
  edge [
    source 10
    target 11
    diffweight "U4*V4^2"
  ]
  edge [
    source 10
    target 13
    diffweight "V4"
  ]
  edge [
    source 10
    target 15
    diffweight "U4*V4^2"
  ]
  edge [
    source 10
    target 14
    diffweight "U4*V4^2"
  ]
  edge [
    source 11
    target 9
    diffweight "V0"
  ]
  edge [
    source 12
    target 7
    diffweight "U1"
  ]
  edge [
    source 12
    target 5
    diffweight "U4"
  ]
  edge [
    source 12
    target 4
    diffweight "V2"
  ]
  edge [
    source 12
    target 0
    diffweight "V2"
  ]
  edge [
    source 12
    target 9
    diffweight "U1*V1*V2"
  ]
  edge [
    source 12
    target 2
    diffweight "V2"
  ]
  edge [
    source 13
    target 7
    diffweight "U2"
  ]
  edge [
    source 13
    target 3
    diffweight "U4"
  ]
  edge [
    source 13
    target 2
    diffweight "V4"
  ]
  edge [
    source 13
    target 0
    diffweight "V4"
  ]
  edge [
    source 13
    target 4
    diffweight "V4"
  ]
  edge [
    source 13
    target 9
    diffweight "U1*V0*V2"
  ]
  edge [
    source 14
    target 9
    diffweight "V2"
  ]
]
