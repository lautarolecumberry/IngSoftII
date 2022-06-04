open util/ordering[State]

abstract sig Object {
	tiempo: Int
}

one sig Indiana, Novia, Padre, Suegro, Linterna
	extends Object {}

fact tiempoCorrer {
	Indiana.tiempo = 1
	Novia.tiempo = 2
	Padre.tiempo = 4
	Suegro.tiempo = 5
	Linterna.tiempo = 0
}

sig State {
	near: set Object,
	far: set Object,
	time: Int,
}

fact initialState {
	let s0 = first[] |
		s0.near = Object && no s0.far && s0.time = 0
}

pred crossBridge [from,fromP,to,toP: set Object, t,tP: Int] {
	some p1, p2: from - Linterna |
		fromP = from - p1 - p2 - Linterna &&
		toP = to + p1 + p2 + Linterna &&
		tP = add[int t, max[int p1.tiempo + int p2.tiempo]]
}

fact stateTransition {
	all s: State, sP: next[s] |
		( Linterna in s.near =>
			crossBridge[s.near,sP.near,s.far,sP.far,s.time,sP.time ] )
		&&
		( Linterna in s.far =>
			crossBridge[s.far,sP.far,s.near,sP.near,s.time,sP.time ] )
}

pred solvePuzzle[] {
//	last[].far = Object && last[].time <= 12
	some s:State | s.far = Object && last[].time <= 12
}
run solvePuzzle for 6 but 6 int
