function findNthValueAfterKSeconds(n, k) {
    let dp = new Array(n).fill(0);
    dp[0] = 1;
    for (let i = 1; i < k; i++) {
        for (let j = 1; j < n; j++) {
            dp[j] = dp[j] + dp[j - 1];
        }
    }
    return dp[n - 1];
}