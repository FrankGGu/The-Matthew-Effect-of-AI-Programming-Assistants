function minFlips(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let flips = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n / 2; j++) {
            const mirrorJ = n - 1 - j;
            if (grid[i][j] !== grid[i][mirrorJ]) {
                flips++;
            }
        }
    }

    return flips;
}