function findMaximumSatisfiedCustomers(s, queries, k) {
    const n = s.length;
    const m = queries.length;
    const result = new Array(m).fill(0);
    const freq = new Array(26).fill(0);

    for (let i = 0; i < n; i++) {
        freq[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    for (let i = 0; i < m; i++) {
        const [l, r] = queries[i];
        const count = new Array(26).fill(0);
        for (let j = l; j <= r; j++) {
            count[s.charCodeAt(j) - 'a'.charCodeAt(0)]++;
        }

        let max = 0;
        for (let c = 0; c < 26; c++) {
            if (count[c] > 0) {
                max = Math.max(max, count[c]);
            }
        }

        let total = 0;
        for (let c = 0; c < 26; c++) {
            if (c !== max) {
                total += freq[c];
            }
        }

        result[i] = total;
    }

    return result;
}