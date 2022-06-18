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

fun topDisk [dis: set Disco]: set Disco {
	dis -- faltaria hacer bien esta funcion y sale hermoso
}

pred enOrden [dis: set Disco] {
  all d,dP: dis |
  d.size > dP.size => d.pos < dP.pos
}

abstract sig Palito{}

one sig P1, P2, P3 extends Palito{}

sig State {
  p: Palito -> set Disco,
}

fact initialState {
  let s0 = first[] |
    s0.p[P1] = Disco &&
    D1.pos = 1 &&
    D2.pos = 2 &&
    D3.pos = 3
}

pred move [from,fromP,to,toP: set Disco] {
  fromP = from - topDisk[from] &&
  toP = to + topDisk[from] &&
  enOrden[toP]
}

fact stateTransition {
  all s: State, sP: next[s] | some pOrigen,pDestino: Palito |
    move[s.p[pOrigen],sP.p[pOrigen],s.p[pDestino],sP.p[pDestino] ]
}

pred solvePuzzle[] {
  some s:State | s.p[P3] = Disco && enOrden[s.p[P3]]
}

run solvePuzzle for 3
