function checkValidGrid(grid) {
    const n = grid.length;
    const pos = new Array(n * n).fill(0).map(() => new Array(2).fill(0));
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            pos[grid[i][j]] = [i, j];
        }
    }
    for (let i = 1; i < n * n; i++) {
        const [x1, y1] = pos[i - 1];
        const [x2, y2] = pos[i];
        const dx = Math.abs(x1 - x2);
        const dy = Math.abs(y1 - y2);
        if (dx + dy !== 1) return false;
    }
    return true;
}