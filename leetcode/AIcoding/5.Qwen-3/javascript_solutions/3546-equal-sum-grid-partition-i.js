function equalSumGridPartition(grid) {
    const rows = grid.length;
    const cols = grid[0].length;

    const rowSums = new Array(rows).fill(0);
    const colSums = new Array(cols).fill(0);

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            rowSums[i] += grid[i][j];
            colSums[j] += grid[i][j];
        }
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (rowSums[i] === colSums[j]) {
                return true;
            }
        }
    }

    return false;
}