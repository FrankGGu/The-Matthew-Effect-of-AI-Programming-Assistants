function maximumValueSum(grid) {
    const n = grid.length;
    const m = grid[0].length;
    const rowMax = new Array(n).fill(0);
    const colMax = new Array(m).fill(0);

    for (let i = 0; i < n; i++) {
        let maxVal = -Infinity;
        for (let j = 0; j < m; j++) {
            if (grid[i][j] > maxVal) {
                maxVal = grid[i][j];
            }
        }
        rowMax[i] = maxVal;
    }

    for (let j = 0; j < m; j++) {
        let maxVal = -Infinity;
        for (let i = 0; i < n; i++) {
            if (grid[i][j] > maxVal) {
                maxVal = grid[i][j];
            }
        }
        colMax[j] = maxVal;
    }

    let maxSum = -Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            for (let k = 0; k < n; k++) {
                if (k === i) continue;
                for (let l = 0; l < m; l++) {
                    if (l === j) continue;
                    for (let p = 0; p < n; p++) {
                        if (p === i || p === k) continue;
                        for (let q = 0; q < m; q++) {
                            if (q === j || q === l) continue;
                            const sum = rowMax[i] + rowMax[k] + rowMax[p] + colMax[j] + colMax[l] + colMax[q];
                            if (sum > maxSum) {
                                maxSum = sum;
                            }
                        }
                    }
                }
            }
        }
    }

    return maxSum;
}