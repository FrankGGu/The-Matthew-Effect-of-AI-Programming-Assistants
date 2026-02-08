function possibleToStamp(grid, stampHeight, stampWidth) {
    const m = grid.length;
    const n = grid[0].length;
    const diff = Array.from({ length: m + 1 }, () => Array(n + 1).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === '0') {
                continue;
            }
            const x1 = Math.max(0, i - stampHeight + 1);
            const y1 = Math.max(0, j - stampWidth + 1);
            const x2 = i;
            const y2 = j;
            diff[x1][y1]++;
            diff[x1][y2 + 1]--;
            diff[x2 + 1][y1]--;
            diff[x2 + 1][y2 + 1]++;
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (i > 0) diff[i][j] += diff[i - 1][j];
            if (j > 0) diff[i][j] += diff[i][j - 1];
            if (i > 0 && j > 0) diff[i][j] -= diff[i - 1][j - 1];
            if (diff[i][j] === 0 && grid[i][j] === '0') {
                return false;
            }
        }
    }

    return true;
}