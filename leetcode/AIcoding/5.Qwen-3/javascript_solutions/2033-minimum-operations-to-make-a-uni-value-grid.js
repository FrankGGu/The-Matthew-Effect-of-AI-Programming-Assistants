function minOperations(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const values = [];

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            values.push(grid[i][j]);
        }
    }

    values.sort((a, b) => a - b);

    const median = values[Math.floor(values.length / 2)];
    let operations = 0;

    for (const val of values) {
        operations += Math.abs(val - median);
    }

    return operations;
}