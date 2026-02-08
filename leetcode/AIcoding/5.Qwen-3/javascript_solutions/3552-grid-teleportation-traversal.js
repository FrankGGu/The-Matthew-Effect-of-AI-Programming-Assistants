function minTimeToTravel(grid, moveCost) {
    const m = grid.length;
    const n = grid[0].length;
    const memo = Array.from({ length: m }, () => Array(n).fill(-1));

    function dfs(i, j) {
        if (i < 0 || i >= m || j < 0 || j >= n) return Infinity;
        if (i === m - 1 && j === n - 1) return 0;
        if (memo[i][j] !== -1) return memo[i][j];

        let minTime = Infinity;
        const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

        for (const [dx, dy] of directions) {
            const ni = i + dx;
            const nj = j + dy;
            if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                const cost = moveCost[grid[i][j]][grid[ni][nj]];
                const time = cost + dfs(ni, nj);
                minTime = Math.min(minTime, time);
            }
        }

        memo[i][j] = minTime;
        return minTime;
    }

    return dfs(0, 0);
}