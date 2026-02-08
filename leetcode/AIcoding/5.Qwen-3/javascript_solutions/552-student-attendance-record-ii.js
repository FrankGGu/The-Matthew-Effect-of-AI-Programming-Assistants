function checkRecord(n) {
    const MOD = 1000000007;
    let dp = [1, 1, 0, 1, 0, 0];
    for (let i = 2; i <= n; i++) {
        let newDp = [0, 0, 0, 0, 0, 0];
        newDp[0] = (dp[0] + dp[1] + dp[2]) % MOD;
        newDp[1] = (dp[3] + dp[4] + dp[5]) % MOD;
        newDp[2] = dp[0] % MOD;
        newDp[3] = (dp[0] + dp[1] + dp[2]) % MOD;
        newDp[4] = (dp[3] + dp[4] + dp[5]) % MOD;
        newDp[5] = dp[3] % MOD;
        dp = newDp;
    }
    return (dp[0] + dp[1] + dp[2] + dp[3] + dp[4] + dp[5]) % MOD;
}