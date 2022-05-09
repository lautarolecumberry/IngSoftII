sig Addr, Data {}

sig Memory {
	addrs: set Addr,
	map: addrs -> one Data
}

sig MainMemory extends Memory { }

sig Cache extends Memory {
	dirty: set addrs
}

sig System {
	cache: Cache,
	main: MainMemory
}

pred Flush [s,sP: System] {
	sP.cache.map = none   // no anda esto pero no se porque xd
	SP.cache.dirty = none
}

pred Load [s,sP: System, d: Data, a: Addr] {
	sP.cache.map = m.map ++ (a -> d) // bien? es un write no mas?
}

pred Consistent [s:System] {
	s.cache.map - (s.cache.dirty -> Data) in s.main.map
}

run Consistent

// cuales son las 4 ops fundamentales????
