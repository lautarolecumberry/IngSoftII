sig Node {}

sig Graph {
	nodes: set Node,
	edges: nodes -> nodes
}

// 4)a) el grafo es aciclico.
pred grafoAciclico [g:Graph] {
	iden not in ^(g.edges)
}

// 4)b) el grafo es no dirigido
pred grafoNoDirigido [g:Graph] {
	(g.edges) = ~(g.edges)
}

// 4)c) el grafo es fuertemente conexo
pred grafoFuertementeConexo [g:Graph] {
	(g.nodes->g.nodes) in *(g.edges)
}

// 4)d) el grafo es conexo
pred grafoConexo [g:Graph] {
	(g.nodes->g.nodes) in *(g.edges + ~(g.edges))
}

// 4)e) el grafo tiene una componente fuertemente conexa
pred subgrafo [g,gP:Graph] {
	((gP.edges) in (g.edges)) && ((gP.nodes) in (g.nodes))
}

pred grafoComponenteFuertementeConexa [g:Graph] {
	some gP:Graph |
		subgrafo[g, gP] && // es subgrafo
		grafoFuertementeConexo[gP] // es fuertemente conexo
		// no es trivial
}
