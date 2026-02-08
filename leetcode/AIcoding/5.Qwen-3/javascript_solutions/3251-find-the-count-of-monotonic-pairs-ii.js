function countMonotonicPairs(n) {
    const MOD = 10 ** 9 + 7;
    const dp = Array(n + 1).fill(0);
    dp[0] = 1;
    for (let i = 1; i <= n; i++) {
        dp[i] = (dp[i - 1] + dp[i - 1]) % MOD;
    }
    return dp[n];
}