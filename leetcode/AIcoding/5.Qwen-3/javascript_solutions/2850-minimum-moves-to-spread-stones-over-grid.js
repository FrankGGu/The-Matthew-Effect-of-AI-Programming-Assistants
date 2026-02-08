function minimumMoves(grid) {
    const n = grid.length;
    const flat = [];
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] > 1) {
                for (let k = 1; k < grid[i][j]; k++) {
                    flat.push([i, j]);
                }
            }
        }
    }
    const targets = [];
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                targets.push([i, j]);
            }
        }
    }
    const m = targets.length;
    const dist = new Array(m).fill(0).map(() => new Array(flat.length).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < flat.length; j++) {
            dist[i][j] = Math.abs(targets[i][0] - flat[j][0]) + Math.abs(targets[i][1] - flat[j][1]);
        }
    }
    const dp = new Array(1 << m).fill(0);
    for (let mask = 1; mask < (1 << m); mask++) {
        let cnt = 0;
        for (let i = 0; i < m; i++) {
            if ((mask >> i) & 1) cnt++;
        }
        if (cnt === 0) continue;
        dp[mask] = Infinity;
        for (let i = 0; i < m; i++) {
            if ((mask >> i) & 1) {
                const prevMask = mask ^ (1 << i);
                for (let j = 0; j < flat.length; j++) {
                    if ((prevMask >> j) & 1) {
                        dp[mask] = Math.min(dp[mask], dp[prevMask] + dist[i][j]);
                    }
                }
            }
        }
    }
    return dp[(1 << m) - 1];
}