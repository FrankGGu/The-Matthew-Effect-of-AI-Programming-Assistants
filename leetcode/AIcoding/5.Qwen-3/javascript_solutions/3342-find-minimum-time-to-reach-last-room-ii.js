function minTimeToReachLastRoom(rooms) {
    const m = rooms.length;
    const n = rooms[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));

    for (let i = m - 1; i >= 0; i--) {
        for (let j = n - 1; j >= 0; j--) {
            if (i === m - 1 && j === n - 1) {
                dp[i][j] = rooms[i][j];
            } else if (i === m - 1) {
                dp[i][j] = dp[i][j + 1] + rooms[i][j];
            } else if (j === n - 1) {
                dp[i][j] = dp[i + 1][j] + rooms[i][j];
            } else {
                dp[i][j] = Math.min(dp[i + 1][j], dp[i][j + 1]) + rooms[i][j];
            }
        }
    }

    return dp[0][0];
}