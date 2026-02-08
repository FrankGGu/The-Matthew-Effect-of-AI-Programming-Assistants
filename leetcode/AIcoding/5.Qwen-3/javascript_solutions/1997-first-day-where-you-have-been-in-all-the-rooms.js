function firstDayWhereYouHaveBeenInAllTheRooms(nextVisit) {
    const n = nextVisit.length;
    const dp = new Array(n).fill(0);
    for (let i = 1; i < n; i++) {
        dp[i] = dp[i - 1] + 1 + (dp[i - 1] - dp[nextVisit[i - 1]] + 1);
    }
    return dp[n - 1];
}