graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3, 4, 5][3, 4, 5, 1, 2]"
  ]
  node [
    id 1
    label "[1, 2, 3, 4][2, 4, 1, 3]"
  ]
  node [
    id 2
    label "[1, 2, 3, 4][4, 3, 1, 2]"
  ]
  node [
    id 3
    label "[1, 2, 3, 4][3, 1, 4, 2]"
  ]
  node [
    id 4
    label "[1, 2, 3][3, 1, 2]"
  ]
  node [
    id 5
    label "[1, 2][2, 1]"
  ]
  node [
    id 6
    label "[1, 2, 3][2, 3, 1]"
  ]
  edge [
    source 0
    target 1
  ]
  edge [
    source 0
    target 2
  ]
  edge [
    source 0
    target 3
  ]
  edge [
    source 4
    target 5
  ]
  edge [
    source 6
    target 5
  ]
]
