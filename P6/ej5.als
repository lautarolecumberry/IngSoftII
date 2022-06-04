sig Elem {}

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
