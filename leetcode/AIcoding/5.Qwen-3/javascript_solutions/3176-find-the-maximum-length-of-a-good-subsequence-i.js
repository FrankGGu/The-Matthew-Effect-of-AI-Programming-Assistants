function maxLength(s, k) {
    const n = s.length;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        for (let j = 0; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            if (s[i - 1] === 'a') {
                if (j > 0) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 1] + 1);
                }
            } else {
                if (j > 0) {
                    dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 1] + 1);
                }
            }
        }
    }

    return dp[n][k];
}