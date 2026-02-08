function countMatchingSubarrays(s, p) {
    const n = s.length;
    const m = p.length;
    let count = 0;

    for (let i = 0; i <= n - m; i++) {
        let match = true;
        for (let j = 0; j < m; j++) {
            if (s[i + j] !== p[j]) {
                match = false;
                break;
            }
        }
        if (match) count++;
    }

    return count;
}