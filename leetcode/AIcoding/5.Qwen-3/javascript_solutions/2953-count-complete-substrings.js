function countCompleteSubstrings(s) {
    let count = 0;
    const n = s.length;
    for (let i = 0; i < n; i++) {
        const map = {};
        for (let j = i; j < n; j++) {
            const c = s[j];
            if (map[c] === undefined) {
                map[c] = 0;
            }
            map[c]++;
            if (Object.keys(map).length === 26) {
                count++;
            }
        }
    }
    return count;
}