function countGoodSubstrings(s) {
    let count = 0;
    for (let i = 0; i <= s.length - 3; i++) {
        const a = s[i];
        const b = s[i + 1];
        const c = s[i + 2];
        if (a !== b && b !== c && a !== c) {
            count++;
        }
    }
    return count;
}