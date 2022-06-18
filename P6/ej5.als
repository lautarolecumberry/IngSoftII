sig Elem {}

one sig E1, E2, E3, E4, E5 extends Elem {}

// 5)a) un preorden: es reflexiva y transitiva
pred preorden [r: Elem -> Elem] {
	(r.~r) in iden && // reflexiva
	r = ^r          // transitiva
}

// 5)b) orden parcial: reflexiva, antisimetrica y transitiva
pred ordenParcial [r: Elem -> Elem] {
	(r.~r) in iden && // reflexiva
	r = ^r &&         // transitiva
	(r & ~r) in iden  // antisimetria
}

// 5)c) orden total: un orden parcial que siempre esta relacionado
pred ordenTotal [r: Elem -> Elem] { // bien???
	ordenParcial[r] &&        // orden parcial
	(univ->univ) in (r + ~r)  // es total
}

// 5)d) orden estricto
pred ordenEstricto [r: Elem -> Elem] { // no se que es un orden estricto, esto es total cambiando el nombre
	ordenParcial[r] &&        // orden parcial
	(univ->univ) in (r + ~r)  // es total
}

// 5)e) que tiene primer elemento
pred tienePrimerElem [r: Elem -> Elem] {
	some e:Elem | 
		all eP: Elem |
			(e -> eP) in r
}

// 5)f) que tiene ultimo elemento
pred tieneUltimoElem [r: Elem -> Elem] {
	some e:Elem | 
		all eP: Elem |
			(eP -> e) in r
}

// asserts
// todo orden parcial es total;
assert parImpTotal {
	all r:Elem -> Elem |
		ordenParcial[r] => ordenTotal[r]
}
// todo orden parcial tiene primer elemento
assert parImpMin {
	all r:Elem -> Elem |
		ordenParcial[r] => tienePrimerElem[r]
}
// todo orden total con primer elemento x y último elemento y satisface x != y;


// la unión de órdenes estrictos es un orden estricto;
assert unionOrdEst {
	all r1,r2:Elem -> Elem |
		ordenEstricto[r1] && ordenEstricto[r2] => ordenEstricto[r1+r2]
}
// la composición de órdenes estrictos es un orden estricto.
assert compOrdEst {
	all r1,r2:Elem -> Elem |
		ordenEstricto[r1] && ordenEstricto[r2] => ordenEstricto[r1.r2]
}

check unionOrdEst
