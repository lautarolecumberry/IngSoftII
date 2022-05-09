sig Node {}

sig Graph {
	nodes: set Node,
	edges: nodes -> nodes
}

// 4)a) el grafo es aciclico.
pred grafoAciclico [g:Graph] {
	iden not in ^(g.edges) // bien???
}

// 4)b) el grafo es no dirigido
pred grafoNoDirigido [g:Graph] {
	(g.edges) in univ // porque esta mal esto?
}
