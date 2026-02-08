function minOperations(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array(m).fill().map(() => Array(n).fill(0));

    for (let j = 0; j < n; j++) {
        dp[0][j] = grid[0][j] === 1 ? 0 : 1;
    }

    for (let i = 1; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let minOp = Infinity;
            for (let k = 0; k < n; k++) {
                if (grid[i][j] === 1 && grid[i-1][k] === 1) {
                    minOp = Math.min(minOp, dp[i-1][k]);
                } else if (grid[i][j] === 0 && grid[i-1][k] === 0) {
                    minOp = Math.min(minOp, dp[i-1][k]);
                }
            }
            dp[i][j] = minOp + 1;
        }
    }

    return Math.min(...dp[m-1]);
}