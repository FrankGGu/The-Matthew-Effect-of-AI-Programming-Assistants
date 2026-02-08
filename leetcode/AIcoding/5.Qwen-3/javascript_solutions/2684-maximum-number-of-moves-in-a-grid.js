function maxMoves(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));

    for (let j = n - 2; j >= 0; j--) {
        for (let i = 0; i < m; i++) {
            let maxMove = 0;
            if (i > 0 && grid[i][j] < grid[i - 1][j]) {
                maxMove = Math.max(maxMove, dp[i - 1][j] + 1);
            }
            if (i < m - 1 && grid[i][j] < grid[i + 1][j]) {
                maxMove = Math.max(maxMove, dp[i + 1][j] + 1);
            }
            if (j < n - 1 && grid[i][j] < grid[i][j + 1]) {
                maxMove = Math.max(maxMove, dp[i][j + 1] + 1);
            }
            dp[i][j] = maxMove;
        }
    }

    let result = 0;
    for (let i = 0; i < m; i++) {
        result = Math.max(result, dp[i][0]);
    }
    return result;
}