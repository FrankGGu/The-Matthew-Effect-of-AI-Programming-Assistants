function numMusicPlaylists(n, goal, k) {
    const MOD = 10**9 + 7;
    const dp = new Array(goal + 1).fill(0).map(() => new Array(n + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= goal; i++) {
        for (let j = 0; j <= n; j++) {
            if (i > 0) {
                // Add a new song
                if (j > 0) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j - 1] * (n - (j - 1))) % MOD;
                }
                // Add a song that has been played before
                if (j > k) {
                    dp[i][j] = (dp[i][j] + dp[i - 1][j] * (j - k)) % MOD;
                }
            }
        }
    }

    return dp[goal][n];
}