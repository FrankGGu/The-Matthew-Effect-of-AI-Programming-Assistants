function maxAreaOfIsland(grid) {
    let maxArea = 0;

    function dfs(r, c) {
        if (r < 0 || r >= grid.length || c < 0 || c >= grid[0].length || grid[r][c] === 0) {
            return 0;
        }
        grid[r][c] = 0;
        let area = 1;
        area += dfs(r + 1, c);
        area += dfs(r - 1, c);
        area += dfs(r, c + 1);
        area += dfs(r, c - 1);
        return area;
    }

    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[0].length; j++) {
            if (grid[i][j] === 1) {
                maxArea = Math.max(maxArea, dfs(i, j));
            }
        }
    }

    return maxArea;
}