function isPossibleToCatchEvents(events, k) {
    const n = events.length;
    const dp = new Array(n).fill(0).map(() => new Array(k + 1).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][0] = 1;
    }

    for (let i = 1; i < n; i++) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = dp[i - 1][j];
            if (events[i][0] >= events[i - 1][1]) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][j - 1] + 1);
            }
        }
    }

    return dp[n - 1][k] >= k + 1;
}