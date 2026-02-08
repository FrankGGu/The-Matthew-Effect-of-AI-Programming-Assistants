function minimumDistance(grid, x1, y1, x2, y2) {
    const n = grid.length;
    const m = grid[0].length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function bfs(startX, startY) {
        const dist = Array.from({ length: n }, () => Array(m).fill(-1));
        const queue = [[startX, startY]];
        dist[startX][startY] = 0;

        while (queue.length > 0) {
            const [x, y] = queue.shift();
            for (const [dx, dy] of dirs) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < n && ny >= 0 && ny < m && grid[nx][ny] === 0 && dist[nx][ny] === -1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    queue.push([nx, ny]);
                }
            }
        }
        return dist;
    }

    const dist1 = bfs(x1, y1);
    const dist2 = bfs(x2, y2);

    let minDist = Infinity;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (grid[i][j] === 0 && dist1[i][j] !== -1 && dist2[i][j] !== -1) {
                minDist = Math.min(minDist, dist1[i][j] + dist2[i][j]);
            }
        }
    }

    return minDist;
}