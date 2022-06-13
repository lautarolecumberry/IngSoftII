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
} {
    cache.addrs in main.addrs
}
// -----------------------------------
pred Read [s:System, a:Addr] {

}

pred Write [s,sP:System, d:Data, a:Addr] {
    sP.cache.map = s.cache.map ++ (a -> d)
    sP.cache.dirty = s.cache.dirty + a
    sP.main.map = s.main.map
}

pred Flush [s,sP: System] {
    sP.cache.dirty = none
    sP.cache.map = s.cache.map
    sP.main.map = s.main.map ++ s.cache.map
}

pred Load [s,sP: System, a: Addr] {
    sP.cache.map = s.cache.map ++ (a -> s.main.map[a])
    sP.cache.dirty = s.cache.dirty - a
    sP.main = s.main
}
// -----------------------------------
pred Consistent [s:System] {
    s.cache.map - (s.cache.dirty -> Data) in s.main.map
}
// -----------------------------------
assert FlushConsistent {
    all s,sp:System | (Consistent[s] && Flush[s, sp]) implies Consistent[sp]
}

assert WriteConsistent {
    all s,sp:System, d:Data, a:Addr | (Consistent[s] && Write[s, sp, d, a]) implies Consistent[sp]
}

assert LoadConsistent {
    all s,sp:System, a:Addr | (Consistent[s] && Load[s, sp, a]) implies Consistent[sp]
}

check FlushConsistent for 3 but 2 System
check WriteConsistent for 3 but 2 System
check LoadConsistent for 3 but 2 System
