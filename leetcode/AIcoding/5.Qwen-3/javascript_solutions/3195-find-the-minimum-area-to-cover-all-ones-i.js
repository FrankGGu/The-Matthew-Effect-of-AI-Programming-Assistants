function minimumArea(grid) {
    let rows = grid.length;
    let cols = grid[0].length;
    let minRow = rows, maxRow = -1, minCol = cols, maxCol = -1;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                minRow = Math.min(minRow, i);
                maxRow = Math.max(maxRow, i);
                minCol = Math.min(minCol, j);
                maxCol = Math.max(maxCol, j);
            }
        }
    }

    return (maxRow - minRow + 1) * (maxCol - minCol + 1);
}