function knightProbability(n, k, row, column) {
    const directions = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]];
    let dp = Array.from({ length: n }, () => Array(n).fill(0));
    dp[row][column] = 1;

    for (let step = 0; step < k; step++) {
        let nextDp = Array.from({ length: n }, () => Array(n).fill(0));
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                if (dp[i][j] === 0) continue;
                for (const [dx, dy] of directions) {
                    const ni = i + dx;
                    const nj = j + dy;
                    if (ni >= 0 && ni < n && nj >= 0 && nj < n) {
                        nextDp[ni][nj] += dp[i][j] / 8;
                    }
                }
            }
        }
        dp = nextDp;
    }

    let total = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            total += dp[i][j];
        }
    }
    return total;
}