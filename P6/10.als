open util/ordering[State]

sig Disco {
  size: Int,
  pos: Int
}

one sig D1, D2, D3
  extends Disco {}

fact sizes {
  D1.size = 1
  D2.size = 2
  D3.size = 3
}

pred enOrden [dis: Disco] {
  all d,dP: dis |
    d.size > dP.size => d.pos < dP.pos
}

sig State {
  p1: set Disco,
  p2: set Disco,
  p3: set Disco,
}

fact initialState {
  let s0 = first[] |
    s0.p1 = Disco &&
    D1.pos = 3 &&
    D2.pos = 2 &&
    D3.pos = 1
}

pred solvePuzzle[] {
  some s:State | s.p3 = Disco // falta el orden
}

run solvePuzzle for 3
