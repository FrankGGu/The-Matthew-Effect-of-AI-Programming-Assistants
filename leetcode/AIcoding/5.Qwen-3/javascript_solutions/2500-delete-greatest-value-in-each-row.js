function deleteGreatestValue(grid) {
    for (let i = 0; i < grid.length; i++) {
        grid[i].sort((a, b) => a - b);
    }
    let result = 0;
    for (let j = 0; j < grid[0].length; j++) {
        let max = 0;
        for (let i = 0; i < grid.length; i++) {
            if (grid[i][j] > max) {
                max = grid[i][j];
            }
        }
        result += max;
    }
    return result;
}