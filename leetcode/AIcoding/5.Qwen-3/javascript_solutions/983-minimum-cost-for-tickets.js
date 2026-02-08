function mincostTickets(days, costs) {
    const daySet = new Set(days);
    const dp = new Array(366).fill(0);

    for (let i = 1; i <= 365; i++) {
        if (!daySet.has(i)) {
            dp[i] = dp[i - 1];
            continue;
        }

        dp[i] = dp[i - 1] + costs[0];
        if (i >= 7) {
            dp[i] = Math.min(dp[i], dp[i - 7] + costs[1]);
        } else {
            dp[i] = Math.min(dp[i], costs[1]);
        }
        if (i >= 30) {
            dp[i] = Math.min(dp[i], dp[i - 30] + costs[2]);
        } else {
            dp[i] = Math.min(dp[i], costs[2]);
        }
    }

    return dp[365];
}