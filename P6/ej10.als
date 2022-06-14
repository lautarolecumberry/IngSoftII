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

pred move [from,fromP,to,toP: set Disco] {
	fromP = from - from.top && // es esto?
	toP = to + from.top
}

fact stateTransition {
	all s: State, sP: next[s] |
		( move[s.p1,sP.p1,s.p2,sP.p2 ] ) && // bien???
		( move[s.p1,sP.p1,s.p3,sP.p3 ] ) &&
		( move[s.p2,sP.p2,s.p1,sP.p1 ] ) &&
		( move[s.p2,sP.p2,s.p3,sP.p3 ] ) &&
		( move[s.p3,sP.p3,s.p1,sP.p1 ] ) &&
		( move[s.p3,sP.p3,s.p2,sP.p2 ] )
}

pred solvePuzzle[] {
  some s:State | s.p3 = Disco && enOrden[s.p3] // falta el orden
}

run solvePuzzle for 3
