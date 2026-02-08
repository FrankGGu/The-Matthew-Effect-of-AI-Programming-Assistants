function cutOffTree(land) {
    const m = land.length;
    const n = land[0].length;
    const queue = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (land[i][j] > 0) {
                queue.push([i, j]);
            }
        }
    }

    queue.sort((a, b) => land[a[0]][a[1]] - land[b[0]][b[1]]);

    let totalSteps = 0;
    let currentX = 0;
    let currentY = 0;

    while (queue.length > 0) {
        const [targetX, targetY] = queue.shift();
        const steps = bfs(land, currentX, currentY, targetX, targetY);
        if (steps === -1) return -1;
        totalSteps += steps;
        currentX = targetX;
        currentY = targetY;
    }

    return totalSteps;

    function bfs(grid, startX, startY, endX, endY) {
        const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        const visited = Array.from({ length: grid.length }, () => Array(grid[0].length).fill(false));
        const queue = [[startX, startY, 0]];
        visited[startX][startY] = true;

        while (queue.length > 0) {
            const [x, y, steps] = queue.shift();
            if (x === endX && y === endY) return steps;
            for (const [dx, dy] of directions) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < grid.length && ny >= 0 && ny < grid[0].length && !visited[nx][ny] && grid[nx][ny] > 0) {
                    visited[nx][ny] = true;
                    queue.push([nx, ny, steps + 1]);
                }
            }
        }

        return -1;
    }
}