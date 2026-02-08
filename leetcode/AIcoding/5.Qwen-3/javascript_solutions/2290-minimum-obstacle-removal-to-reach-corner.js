function minimumObstacleRemoval(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const queue = [];
    const dist = Array.from({ length: m }, () => Array(n).fill(Infinity));

    dist[0][0] = 0;
    queue.push([0, 0]);

    while (queue.length > 0) {
        const [x, y] = queue.shift();

        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;

            if (nx >= 0 && ny >= 0 && nx < m && ny < n) {
                const newDist = dist[x][y] + (grid[nx][ny] === '0' ? 0 : 1);

                if (newDist < dist[nx][ny]) {
                    dist[nx][ny] = newDist;
                    queue.push([nx, ny]);
                }
            }
        }
    }

    return dist[m - 1][n - 1];
}