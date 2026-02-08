function minimumString(a, b, c) {
    function contains(s, t) {
        return s.includes(t);
    }

    function merge(s, t) {
        if (contains(s, t)) return s;
        if (contains(t, s)) return t;
        for (let i = 1; i < Math.min(s.length, t.length); i++) {
            if (s.slice(-i) === t.slice(0, i)) {
                return s + t.slice(i);
            }
        }
        return s + t;
    }

    const candidates = [];
    const permutations = [[a, b, c], [a, c, b], [b, a, c], [b, c, a], [c, a, b], [c, b, a]];
    for (const [x, y, z] of permutations) {
        const temp = merge(merge(x, y), z);
        candidates.push(temp);
    }

    let result = candidates[0];
    for (let i = 1; i < candidates.length; i++) {
        if (candidates[i].length < result.length || (candidates[i].length === result.length && candidates[i] < result)) {
            result = candidates[i];
        }
    }
    return result;
}