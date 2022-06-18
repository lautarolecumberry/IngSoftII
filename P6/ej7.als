sig Interprete {}

sig Cancion {}

sig Catalogo {
	canciones: set Cancion,
	interpretes: set Interprete,
	interpretaciones: canciones some -> some interpretes
} {
--	interpretes = canciones.interpretaciones &&
--	canciones = interpretaciones.interpretes
}

assert checkProperty{
	all c:Catalogo |
		all s: c.canciones | 
			some i: c.interpretes |
				i in c.interpretaciones[s] &&
		all i: c.interpretes |
			some s: c.canciones |
				i in c.interpretaciones[s]
}

-- 7)a) Un predicado que dado un catálogo y una cacnión con su interprete,
-- devuelva un nuevo catálogo igual al primero pero con esa interpretación agragada.
pred agregar [cat,catP: Catalogo, s:Cancion, i:Interprete] {
	catP.canciones = cat.canciones + s &&
	catP.interpretes = cat.interpretes + i &&
	catP.interpretaciones = cat.interpretaciones + (s->i)
}

-- 7)b) Un predicado que dado un catálogo y una canción con su interprete, 
-- devuelva un nuevo catálogo igual al primero pero eliminando esa interpretación.
pred quitar [cat,catP: Catalogo, s:Cancion, i:Interprete] {
	catP.interpretaciones = cat.interpretaciones - (s->i) && 
	cat.interpretaciones.i = s implies 	catP.interpretes = cat.interpretes - i &&
	cat.interpretaciones[s] = i implies 	catP.canciones = cat.canciones - s
}

-- 7)c) Una función que, dado un catálogo, devuelva los pares de interpretes 
-- que interpretan la mismacanción.
fun coartists[cat: Catalogo, s:Cancion]: (Interprete -> Interprete) {	
	(~(cat.interpretaciones)).(cat.interpretaciones)
}

check checkProperty for 3 but 1 Catalogo
