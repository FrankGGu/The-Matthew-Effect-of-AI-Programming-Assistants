function jewelleryValue(grid) {
    if (!grid || grid.length === 0 || grid[0].length === 0) return 0;

    const m = grid.length;
    const n = grid[0].length;

    for (let i = 1; i < m; i++) {
        grid[i][0] += grid[i - 1][0];
    }

    for (let j = 1; j < n; j++) {
        grid[0][j] += grid[0][j - 1];
    }

    for (let i = 1; i < m; i++) {
        for (let j = 1; j < n; j++) {
            grid[i][j] += Math.max(grid[i - 1][j], grid[i][j - 1]);
        }
    }

    return grid[m - 1][n - 1];
}