function maxScore(s, k) {
    const n = s.length;
    const dp = Array.from({ length: n }, () => Array(k + 1).fill(-1));
    const lastOccurrence = Array(26).fill(-1);

    for (let i = 0; i < n; i++) {
        const c = s[i];
        const idx = c.charCodeAt(0) - 'a'.charCodeAt(0);
        if (lastOccurrence[idx] !== -1) {
            for (let j = 1; j <= k; j++) {
                if (dp[lastOccurrence[idx]][j - 1] !== -1) {
                    dp[i][j] = Math.max(dp[i][j], dp[lastOccurrence[idx]][j - 1] + 1);
                }
            }
        }
        for (let j = 1; j <= k; j++) {
            if (dp[i - 1] && dp[i - 1][j] !== -1) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j]);
            }
        }
        lastOccurrence[idx] = i;
    }

    let max = 0;
    for (let j = 1; j <= k; j++) {
        max = Math.max(max, dp[n - 1][j]);
    }
    return max;
}