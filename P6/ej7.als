sig Interprete {}

sig Cancion {}

sig Catalogo {
	canciones: set Cancion,
	interpretes: set Interprete,
	interpretaciones: canciones -> interpretes
}{
	// todas las canciones estan registradas por un interprete
	all s: canciones | some i: interpretes | interpretaciones.s = i &&
	// todo interprete tiene alguna tiene alguna cancion registrada
	all i: interpretes | some s: canciones | interpretaciones.s = i
}  // como hago esto?

// (a) Un predicado que dado un cat ́alogo y una cacni ́on con su interprete, devuelva un nuevo cat ́alogo igual al primero pero con esa interpretaci ́on agragada.
pred agregarCancion [c,cP: Catalogo, s: Cancion, i: interprete] {
	cP.canciones = c.canciones + s &&
	cP.interpretes = c.interpretes + i &&
	cP.interpretaciones = c.interpretaciones + (s -> i)
}

// (b) Un predicado que dado un cat ́alogo y una canci ́on con su interprete, devuelva un nuevo cat ́alogo igual al primero pero eliminando esa interpretaci ́on.
pred sacarCancion [c,cP: Catalogo, s: Cancion, i: interprete] {
	cP.canciones = c.canciones - s &&
	cP.interpretes = c.interpretes - i &&
	cP.interpretaciones = c.interpretaciones - (s -> i)
}

// (c) Una funci ́on que, dado un cat ́alogo, devuelva los pares de interpretes que interpretan la misma canci ́on.
fun pares [c: Catalogo] {
	???????? como haria esto?
	c.cancion = i && c.cancion = iP, i!=iP => return (i, iP)
}
