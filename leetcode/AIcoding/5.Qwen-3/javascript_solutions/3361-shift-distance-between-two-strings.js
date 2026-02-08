function shiftDistance(s, t) {
    const n = s.length;
    const m = t.length;
    if (n !== m) return -1;
    let distance = 0;
    for (let i = 0; i < n; i++) {
        const sChar = s[i].charCodeAt(0);
        const tChar = t[i].charCodeAt(0);
        const diff = Math.abs(sChar - tChar);
        distance += Math.min(diff, 26 - diff);
    }
    return distance;
}