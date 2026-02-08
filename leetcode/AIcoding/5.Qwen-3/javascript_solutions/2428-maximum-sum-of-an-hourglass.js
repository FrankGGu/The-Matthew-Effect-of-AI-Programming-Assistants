function maxSumHourglass(grid) {
    let maxSum = -Infinity;
    const rows = grid.length;
    const cols = grid[0].length;

    for (let i = 0; i <= rows - 3; i++) {
        for (let j = 0; j <= cols - 3; j++) {
            const top = grid[i][j] + grid[i][j+1] + grid[i][j+2];
            const middle = grid[i+1][j+1];
            const bottom = grid[i+2][j] + grid[i+2][j+1] + grid[i+2][j+2];
            const sum = top + middle + bottom;
            if (sum > maxSum) {
                maxSum = sum;
            }
        }
    }

    return maxSum;
}