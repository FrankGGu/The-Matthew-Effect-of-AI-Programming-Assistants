function relocateMarbles(marbles, moveFrom, moveTo) {
    const set = new Set(marbles);
    for (let i = 0; i < moveFrom.length; i++) {
        if (set.has(moveFrom[i])) {
            set.delete(moveFrom[i]);
            set.add(moveTo[i]);
        }
    }
    return Array.from(set).sort((a, b) => a - b);
}