function sumScores(s) {
    const n = s.length;
    const lps = new Array(n).fill(0);
    let len = 0;
    for (let i = 1; i < n; i++) {
        while (len > 0 && s[i] !== s[len]) {
            len = lps[len - 1];
        }
        if (s[i] === s[len]) {
            len++;
        }
        lps[i] = len;
    }
    return lps.reduce((sum, val) => sum + val, 0);
}