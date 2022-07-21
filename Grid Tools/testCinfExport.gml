graph [
  directed 1
  node [
    id 0
    label "[1, 2, 3]"
  ]
  node [
    id 1
    label "[2, 1, 3]"
  ]
  node [
    id 2
    label "[2, 3, 1]"
  ]
  node [
    id 3
    label "[3, 2, 1]"
  ]
  node [
    id 4
    label "[3, 1, 2]"
  ]
  node [
    id 5
    label "[1, 3, 2]"
  ]
  edge [
    source 0
    target 1
    weight "[[1, 0, 0], [0, 0, 0]]"
  ]
  edge [
    source 0
    target 5
    weight "[[0, 1, 0], [0, 0, 0]]"
  ]
  edge [
    source 0
    target 3
    weight "[[0, 0, 1], [0, 0, 0]]"
  ]
  edge [
    source 1
    target 0
    weight "[[0, 0, 0], [0, 0, 1]]"
  ]
  edge [
    source 1
    target 2
    weight "[[0, 0, 1], [0, 0, 0]]"
  ]
  edge [
    source 1
    target 4
    weight "[[0, 1, 0], [1, 0, 0]]"
  ]
  edge [
    source 2
    target 3
    weight "[[0, 0, 0], [1, 0, 0]]"
  ]
  edge [
    source 2
    target 1
    weight "[[0, 0, 0], [0, 1, 0]]"
  ]
  edge [
    source 2
    target 5
    weight "[[0, 0, 0], [0, 0, 1]]"
  ]
  edge [
    source 3
    target 2
    weight "[[0, 1, 0], [0, 0, 0]]"
  ]
  edge [
    source 3
    target 4
    weight "[[1, 0, 0], [0, 0, 1]]"
  ]
  edge [
    source 3
    target 0
    weight "[[0, 0, 0], [0, 1, 0]]"
  ]
  edge [
    source 4
    target 5
    weight "[[0, 0, 0], [0, 0, 0]]"
  ]
  edge [
    source 4
    target 3
    weight "[[0, 0, 0], [0, 0, 0]]"
  ]
  edge [
    source 4
    target 1
    weight "[[0, 0, 0], [0, 0, 0]]"
  ]
  edge [
    source 5
    target 4
    weight "[[0, 0, 1], [0, 1, 0]]"
  ]
  edge [
    source 5
    target 0
    weight "[[0, 0, 0], [1, 0, 0]]"
  ]
  edge [
    source 5
    target 2
    weight "[[1, 0, 0], [0, 0, 0]]"
  ]
]
