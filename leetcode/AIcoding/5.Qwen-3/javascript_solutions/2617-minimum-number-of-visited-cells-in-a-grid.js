function findMinimumVisitedCells(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(Infinity));
    const queue = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dp[i][j] = 1;
                queue.push([i, j]);
            }
        }
    }

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    while (queue.length > 0) {
        const [i, j] = queue.shift();
        const steps = dp[i][j];

        for (const [dx, dy] of directions) {
            let x = i + dx;
            let y = j + dy;
            while (x >= 0 && x < m && y >= 0 && y < n && grid[x][y] === 1) {
                if (dp[x][y] > steps + 1) {
                    dp[x][y] = steps + 1;
                    queue.push([x, y]);
                }
                x += dx;
                y += dy;
            }
        }
    }

    return dp[m - 1][n - 1] === Infinity ? -1 : dp[m - 1][n - 1];
}