function minPathCost(grid) {
    const rows = grid.length;
    const cols = grid[0].length;

    for (let i = 1; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            let minPrev = Infinity;
            for (let k = 0; k < cols; k++) {
                minPrev = Math.min(minPrev, grid[i - 1][k]);
            }
            grid[i][j] += minPrev;
        }
    }

    return Math.min(...grid[rows - 1]);
}