var numTilings = function(n) {
    const MOD = 10**9 + 7;
    if (n === 1) return 1;
    if (n === 2) return 2;
    if (n === 3) return 5;

    let dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    dp[1] = 1;
    dp[2] = 2;
    dp[3] = 5;

    for (let i = 4; i <= n; i++) {
        dp[i] = (2 * dp[i - 1] + dp[i - 3]) % MOD;
    }

    return dp[n];
};