function minSkips(s, t, targetSeconds) {
    const n = s.length;
    const dp = new Array(n + 1).fill(0).map(() => new Array(n + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        dp[i][0] = dp[i - 1][0] + s[i - 1];
    }

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= i; j++) {
            dp[i][j] = Math.min(dp[i - 1][j - 1], dp[i - 1][j] + s[i - 1]);
        }
    }

    for (let k = 0; k <= n; k++) {
        if (dp[n][k] <= targetSeconds) {
            return k;
        }
    }

    return -1;
}