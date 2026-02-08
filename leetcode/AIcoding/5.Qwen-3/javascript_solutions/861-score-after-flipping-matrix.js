function matrixScore(grid) {
    const m = grid.length;
    const n = grid[0].length;

    for (let i = 0; i < m; i++) {
        if (grid[i][0] === 0) {
            for (let j = 0; j < n; j++) {
                grid[i][j] ^= 1;
            }
        }
    }

    for (let j = 1; j < n; j++) {
        let count = 0;
        for (let i = 0; i < m; i++) {
            count += grid[i][j];
        }
        if (count < m - count) {
            for (let i = 0; i < m; i++) {
                grid[i][j] ^= 1;
            }
        }
    }

    let score = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            score += grid[i][j] * Math.pow(2, n - 1 - j);
        }
    }

    return score;
}