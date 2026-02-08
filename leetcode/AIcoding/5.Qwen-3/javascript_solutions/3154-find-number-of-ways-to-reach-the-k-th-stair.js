function waysToReachKthStair(k) {
    const MOD = 1000000007;
    const dp = new Array(k + 1).fill(0);
    dp[0] = 1;
    for (let i = 1; i <= k; i++) {
        dp[i] = dp[i - 1];
        if (i >= 2) dp[i] = (dp[i] + dp[i - 2]) % MOD;
        if (i >= 3) dp[i] = (dp[i] + dp[i - 3]) % MOD;
    }
    return dp[k];
}