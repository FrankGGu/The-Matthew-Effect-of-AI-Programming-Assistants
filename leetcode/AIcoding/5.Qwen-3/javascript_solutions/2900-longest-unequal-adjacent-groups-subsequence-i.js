function longestUnequalAdjacentGroupsSubsequence(n, queries) {
    const result = [];
    for (const q of queries) {
        const subseq = [];
        let prev = -1;
        for (let i = 0; i < n; i++) {
            if (i === 0 || Math.abs(i - prev) > 1) {
                subseq.push(i);
                prev = i;
            }
        }
        result.push(subseq[q]);
    }
    return result;
}