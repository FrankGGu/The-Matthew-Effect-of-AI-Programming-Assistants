function countStableBinaryArrays(n) {
    const MOD = 10 ** 9 + 7;
    let dp = [0, 1];
    for (let i = 2; i <= n; i++) {
        dp[i] = (dp[i - 1] + dp[i - 2]) % MOD;
    }
    return dp[n];
}