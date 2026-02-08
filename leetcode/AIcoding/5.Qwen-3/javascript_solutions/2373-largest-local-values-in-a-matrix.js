function largestLocal(grid) {
    const n = grid.length;
    const result = new Array(n - 2).fill(0).map(() => new Array(n - 2).fill(0));

    for (let i = 0; i < n - 2; i++) {
        for (let j = 0; j < n - 2; j++) {
            let max = 0;
            for (let x = i; x < i + 3; x++) {
                for (let y = j; y < j + 3; y++) {
                    max = Math.max(max, grid[x][y]);
                }
            }
            result[i][j] = max;
        }
    }

    return result;
}