function repeatedStringMatch(a, b) {
    let count = 1;
    let s = a;
    while (s.length < b.length) {
        s += a;
        count++;
    }
    if (s.includes(b)) return count;
    s += a;
    count++;
    if (s.includes(b)) return count;
    return -1;
}