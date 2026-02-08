function getAverageGrid(grid, k) {
    const m = grid.length;
    const n = grid[0].length;
    const result = new Array(m).fill(0).map(() => new Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            let sum = 0;
            let count = 0;
            for (let x = Math.max(0, i - k); x <= Math.min(m - 1, i + k); x++) {
                for (let y = Math.max(0, j - k); y <= Math.min(n - 1, j + k); y++) {
                    sum += grid[x][y];
                    count++;
                }
            }
            result[i][j] = Math.floor(sum / count);
        }
    }

    return result;
}