function construct2DGrid(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const result = [];

    for (let i = 0; i < rows; i++) {
        const row = [];
        for (let j = 0; j < cols; j++) {
            row.push(grid[i][j]);
        }
        result.push(row);
    }

    return result;
}