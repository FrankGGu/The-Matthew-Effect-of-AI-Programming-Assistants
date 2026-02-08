function longestIncreasingPath(matrix) {
    if (matrix.length === 0) return 0;
    const m = matrix.length;
    const n = matrix[0].length;
    const dp = Array.from({ length: m }, () => Array(n).fill(0));
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    function dfs(i, j) {
        if (dp[i][j] !== 0) return dp[i][j];
        let maxPath = 1;
        for (const [dx, dy] of directions) {
            const x = i + dx;
            const y = j + dy;
            if (x >= 0 && x < m && y >= 0 && y < n && matrix[x][y] > matrix[i][j]) {
                const path = 1 + dfs(x, y);
                maxPath = Math.max(maxPath, path);
            }
        }
        dp[i][j] = maxPath;
        return maxPath;
    }

    let result = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            result = Math.max(result, dfs(i, j));
        }
    }
    return result;
}