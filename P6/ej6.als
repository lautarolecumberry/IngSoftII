// tengo que modelar T??

// a) una simulacion.
pred simulacion[R: relacionTransicion] {
	~R.T[a] in T[a].~R
}

// b) una bisimulacion.
pred bisimulacion[R: relacionTransicion] {
	simulacion[R] and
	R.T[a] in T[a].R
}

// c) una bisimulacion debil.
pred bisimulacionDebil[R: relacionTransicion] {
	~R.T[tau]* in T[tau]*.~R and
	~R.T[tau]*.T[a]*.T[tau]* in T[tau]*.T[a]*.T[tau]*.~R
	// falta algo aca pero no me acuerdo que
}

assert A {
	all b:rel | bisimulacion[b] && simulacion[b] // bien???
}

assert B {
	all b:rel | bisimulacion[b] && bisimulacionDebil[b] // bien???
}

assert C {
	all b,bP: rel |
		bisimulacion[b] && bisimulacion[bP] => bisimulacion[b.bP] // bien?????
}
