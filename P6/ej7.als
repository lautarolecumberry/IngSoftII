sig Interprete {}

sig Cancion {}

sig Catalogo {
	canciones: set Cancion,
	interpretes: set Interprete,
	interpretaciones: canciones some -> some interpretes
} {

}

assert showCatalogo{
	all c:Catalogo |
		all s: c.canciones | some i: c.interpretes | i in c.interpretaciones[s] &&
		all i: c.interpretes | some s: c.canciones | i in c.interpretaciones[s]
}

check showCatalogo for 3 but 1 Catalogo







sig Interprete {}

sig Cancion {}

sig Catalogo {
	canciones: set Cancion,
	interpretes: set Interprete,
	interpretaciones: canciones -> interpretes
} {
	interpretes = canciones.interpretaciones &&
	canciones = interpretaciones.interpretes
}

assert showCatalogo{
	all c:Catalogo |
		all s: c.canciones | some i: c.interpretes | i in c.interpretaciones[s] &&
		all i: c.interpretes | some s: c.canciones | i in c.interpretaciones[s]
}

check showCatalogo for 3 but 1 Catalogo
