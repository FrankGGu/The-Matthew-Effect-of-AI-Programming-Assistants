function findMinimumPossibleSum(n) {
    const dp = new Array(n + 1).fill(0);
    dp[1] = 1;
    for (let i = 2; i <= n; i++) {
        dp[i] = dp[i - 1] + (i % 2 === 0 ? 1 : 0);
    }
    return dp[n];
}