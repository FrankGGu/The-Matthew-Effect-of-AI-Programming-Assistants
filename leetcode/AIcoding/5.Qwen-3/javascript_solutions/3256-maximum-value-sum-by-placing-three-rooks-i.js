function maximumValueSum(grid) {
    const n = grid.length;
    const rowSums = new Array(n).fill(0);
    const colSums = new Array(n).fill(0);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            rowSums[i] += grid[i][j];
            colSums[j] += grid[i][j];
        }
    }

    rowSums.sort((a, b) => b - a);
    colSums.sort((a, b) => b - a);

    return rowSums[0] + rowSums[1] + rowSums[2] + colSums[0] + colSums[1] + colSums[2];
}