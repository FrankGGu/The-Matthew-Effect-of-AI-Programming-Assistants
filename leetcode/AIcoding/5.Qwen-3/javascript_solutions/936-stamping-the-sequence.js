function numRollsToTarget(n, k, target) {
    const MOD = 10 ** 9 + 7;
    const dp = new Array(n + 1).fill(0).map(() => new Array(target + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= target; j++) {
            for (let m = 1; m <= k && j - m >= 0; m++) {
                dp[i][j] += dp[i - 1][j - m];
                dp[i][j] %= MOD;
            }
        }
    }

    return dp[n][target];
}