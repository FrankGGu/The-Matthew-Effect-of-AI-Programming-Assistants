function minDisplayUnits(rooms) {
    const n = rooms.length;
    const dp = new Array(n).fill(0);
    dp[0] = rooms[0];
    for (let i = 1; i < n; i++) {
        dp[i] = Math.min(dp[i - 1] + rooms[i], dp[i - 1] + 1);
    }
    return dp[n - 1];
}