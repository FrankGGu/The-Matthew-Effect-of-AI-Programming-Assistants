function numberOfDistinctColors(balls) {
    const set = new Set();
    for (const c of balls) {
        set.add(c);
    }
    return set.size;
}