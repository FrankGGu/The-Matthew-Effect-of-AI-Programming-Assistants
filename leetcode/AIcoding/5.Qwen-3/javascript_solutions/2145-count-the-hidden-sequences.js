function numberOfWays(target) {
    const MOD = 10 ** 9 + 7;
    const n = target.length;
    const dp = new Array(n).fill(0);
    dp[0] = 1;

    for (let i = 1; i < n; i++) {
        if (target[i] > target[i - 1]) {
            dp[i] = dp[i - 1];
        } else if (target[i] < target[i - 1]) {
            dp[i] = dp[i - 1];
        } else {
            dp[i] = (dp[i - 1] * 2) % MOD;
        }
    }

    return dp[n - 1];
}