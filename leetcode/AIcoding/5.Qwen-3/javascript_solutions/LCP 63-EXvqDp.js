function findBall(grid) {
    const rows = grid.length;
    const cols = grid[0].length;

    for (let col = 0; col < cols; col++) {
        let currentCol = col;
        for (let row = 0; row < rows; row++) {
            const nextCol = currentCol + grid[row][currentCol];
            if (nextCol < 0 || nextCol >= cols) {
                return -1;
            }
            currentCol = nextCol;
        }
        return currentCol;
    }
    return -1;
}