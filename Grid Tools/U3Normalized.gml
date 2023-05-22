graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3]"
    HasBeenGraded 1
    AGrading 0
    UGrading 0
    VGrading 0
  ]
  node [
    id 1
    label "[2, 1, 3]"
    HasBeenGraded 1
    UGrading 3
    VGrading -1
    AGrading 2
  ]
  node [
    id 2
    label "[3, 2, 1]"
    HasBeenGraded 1
    UGrading 1
    VGrading -3
    AGrading 2
  ]
  node [
    id 3
    label "[2, 3, 1]"
    HasBeenGraded 1
    UGrading 4
    VGrading -4
    AGrading 4
  ]
  edge [
    source 1
    target 0
    diffweight "V0^2"
  ]
  edge [
    source 1
    target 3
    diffweight "U0^2"
  ]
  edge [
    source 2
    target 3
    diffweight "U0^2"
  ]
  edge [
    source 2
    target 0
    diffweight "V0^2"
  ]
]
