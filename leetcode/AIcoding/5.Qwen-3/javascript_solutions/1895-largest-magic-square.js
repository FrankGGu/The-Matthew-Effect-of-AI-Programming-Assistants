function isMagic(grid, x, y, k) {
    const rows = new Set();
    const cols = new Set();
    const diag1 = 0;
    const diag2 = 0;

    for (let i = 0; i < k; i++) {
        let rowSum = 0;
        let colSum = 0;
        for (let j = 0; j < k; j++) {
            rowSum += grid[x + i][y + j];
            colSum += grid[x + j][y + i];
        }
        rows.add(rowSum);
        cols.add(colSum);
    }

    for (let i = 0; i < k; i++) {
        diag1 += grid[x + i][y + i];
        diag2 += grid[x + i][y + k - 1 - i];
    }

    return rows.size === 1 && cols.size === 1 && rows.has(diag1) && rows.has(diag2);
}

function largestMagicSquare(grid) {
    const m = grid.length;
    const n = grid[0].length;
    let maxK = 1;

    for (let k = 2; k <= Math.min(m, n); k++) {
        for (let i = 0; i <= m - k; i++) {
            for (let j = 0; j <= n - k; j++) {
                if (isMagic(grid, i, j, k)) {
                    maxK = k;
                    break;
                }
            }
        }
    }

    return maxK;
}