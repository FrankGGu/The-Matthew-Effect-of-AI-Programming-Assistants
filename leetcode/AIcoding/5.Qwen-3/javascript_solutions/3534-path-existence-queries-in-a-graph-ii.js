function isPossible(grid, x1, y1, x2, y2) {
    const n = grid.length;
    const m = grid[0].length;
    const visited = new Array(n).fill().map(() => new Array(m).fill(false));

    function dfs(x, y) {
        if (x < 0 || y < 0 || x >= n || y >= m || visited[x][y] || grid[x][y] === 0) return false;
        if (x === x2 && y === y2) return true;
        visited[x][y] = true;
        const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        for (const [dx, dy] of directions) {
            if (dfs(x + dx, y + dy)) return true;
        }
        return false;
    }

    return dfs(x1, y1);
}

function checkValidGrid(grid) {
    const n = grid.length;
    const m = grid[0].length;
    const visited = new Array(n).fill().map(() => new Array(m).fill(false));

    function dfs(x, y) {
        if (x < 0 || y < 0 || x >= n || y >= m || visited[x][y] || grid[x][y] === 0) return;
        visited[x][y] = true;
        const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        for (const [dx, dy] of directions) {
            dfs(x + dx, y + dy);
        }
    }

    dfs(0, 0);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (grid[i][j] === 1 && !visited[i][j]) return false;
        }
    }

    return true;
}

function getQueriesResult(grid, queries) {
    const result = [];
    if (!checkValidGrid(grid)) {
        for (let i = 0; i < queries.length; i++) {
            result.push(false);
        }
        return result;
    }
    for (const [x1, y1, x2, y2] of queries) {
        result.push(isPossible(grid, x1, y1, x2, y2));
    }
    return result;
}