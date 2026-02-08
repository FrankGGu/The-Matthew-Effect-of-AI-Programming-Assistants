function shortestBridge(grid) {
    const n = grid.length;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    function dfs(i, j) {
        if (i < 0 || j < 0 || i >= n || j >= n || grid[i][j] !== 1) return;
        grid[i][j] = 2;
        for (const [dx, dy] of directions) {
            dfs(i + dx, j + dy);
        }
    }

    function bfs() {
        const queue = [];
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] === 1) {
                    queue.push([i, j]);
                    grid[i][j] = 2;
                }
            }
        }

        let distance = 0;
        while (queue.length > 0) {
            const size = queue.length;
            for (let k = 0; k < size; k++) {
                const [i, j] = queue.shift();
                for (const [dx, dy] of directions) {
                    const ni = i + dx;
                    const nj = j + dy;
                    if (ni >= 0 && nj >= 0 && ni < n && nj < n) {
                        if (grid[ni][nj] === 1) {
                            return distance;
                        }
                        if (grid[ni][nj] === 0) {
                            grid[ni][nj] = 2;
                            queue.push([ni, nj]);
                        }
                    }
                }
            }
            distance++;
        }
        return -1;
    }

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dfs(i, j);
                return bfs();
            }
        }
    }
    return -1;
}