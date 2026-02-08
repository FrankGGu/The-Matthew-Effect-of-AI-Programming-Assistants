function sumOfArrayProductOfMagicalSequences(n) {
    const MOD = 1000000007;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    for (let i = 1; i <= n; i++) {
        dp[i] = (dp[i - 1] * (i + 1)) % MOD;
    }
    return dp[n];
}