function isPossibleToEqualizeWithKOperations(s, k) {
    const count = new Array(26).fill(0);
    for (let c of s) {
        count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }
    let distinct = 0;
    for (let i = 0; i < 26; i++) {
        if (count[i] > 0) distinct++;
    }
    if (distinct === 0) return false;
    if (k < distinct) return false;
    const total = s.length;
    const needed = k - distinct;
    for (let i = 0; i < 26; i++) {
        if (count[i] > 0) {
            const extra = count[i] - 1;
            if (extra <= needed) {
                needed -= extra;
            } else {
                return false;
            }
        }
    }
    return true;
}