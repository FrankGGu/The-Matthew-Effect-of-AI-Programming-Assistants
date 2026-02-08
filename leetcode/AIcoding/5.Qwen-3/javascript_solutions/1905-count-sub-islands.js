function countSubIslands(grid1, grid2) {
    const m = grid2.length;
    const n = grid2[0].length;

    function dfs(i, j) {
        if (i < 0 || i >= m || j < 0 || j >= n || grid2[i][j] === 0) {
            return true;
        }

        grid2[i][j] = 0;

        const left = dfs(i, j - 1);
        const right = dfs(i, j + 1);
        const up = dfs(i - 1, j);
        const down = dfs(i + 1, j);

        return left && right && up && down;
    }

    let count = 0;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid2[i][j] === 1) {
                if (dfs(i, j)) {
                    count++;
                }
            }
        }
    }

    return count;
}