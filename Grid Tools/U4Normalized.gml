graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3, 4]"
    HasBeenGraded 1
    AGrading 0
    UGrading 0
    VGrading 0
  ]
  node [
    id 1
    label "[2, 1, 3, 4]"
    HasBeenGraded 1
    UGrading 3
    VGrading -3
    AGrading 3
  ]
  node [
    id 2
    label "[1, 3, 2, 4]"
    HasBeenGraded 1
    UGrading 1
    VGrading -3
    AGrading 2
  ]
  node [
    id 3
    label "[4, 2, 3, 1]"
    HasBeenGraded 1
    UGrading 1
    VGrading -3
    AGrading 2
  ]
  node [
    id 4
    label "[2, 3, 1, 4]"
    HasBeenGraded 1
    UGrading 4
    VGrading -4
    AGrading 4
  ]
  node [
    id 5
    label "[2, 4, 3, 1]"
    HasBeenGraded 1
    UGrading 2
    VGrading -4
    AGrading 3
  ]
  node [
    id 6
    label "[3, 2, 4, 1]"
    HasBeenGraded 1
    UGrading 2
    VGrading -4
    AGrading 3
  ]
  node [
    id 7
    label "[2, 3, 4, 1]"
    HasBeenGraded 1
    UGrading 5
    VGrading -7
    AGrading 6
  ]
  edge [
    source 1
    target 0
    diffweight "V0^2"
  ]
  edge [
    source 2
    target 0
    diffweight "V0^2"
  ]
  edge [
    source 3
    target 0
    diffweight "V0^2"
  ]
  edge [
    source 4
    target 7
    diffweight "U0^2"
  ]
  edge [
    source 5
    target 7
    diffweight "U0^2"
  ]
  edge [
    source 6
    target 7
    diffweight "U0^2"
  ]
]
