function kInversePairs(n, k) {
    const MOD = 1000000007;
    const dp = new Array(n + 1).fill(0).map(() => new Array(k + 1).fill(0));
    dp[0][0] = 1;
    for (let i = 1; i <= n; i++) {
        dp[i][0] = 1;
        for (let j = 1; j <= k; j++) {
            dp[i][j] = (dp[i][j - 1] + dp[i - 1][j] - (j >= i ? dp[i - 1][j - i] : 0)) % MOD;
            if (dp[i][j] < 0) dp[i][j] += MOD;
        }
    }
    return dp[n][k];
}