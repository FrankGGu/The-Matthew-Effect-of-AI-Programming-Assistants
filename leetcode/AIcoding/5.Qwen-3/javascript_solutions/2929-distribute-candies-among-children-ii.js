function distributeCandies(n, k) {
    const MOD = 1000000007;
    const dp = Array.from({ length: k + 1 }, () => Array(n + 1).fill(0));

    for (let i = 0; i <= n; i++) {
        dp[0][i] = 0;
    }

    for (let i = 1; i <= k; i++) {
        dp[i][0] = 1;
    }

    for (let i = 1; i <= k; i++) {
        for (let j = 1; j <= n; j++) {
            dp[i][j] = (dp[i][j - 1] + dp[i - 1][j - 1]) % MOD;
        }
    }

    return dp[k][n];
}