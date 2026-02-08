function isReachableInTime(grid, t) {
    const m = grid.length;
    const n = grid[0].length;
    let start = null;
    let end = null;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 2) {
                start = [i, j];
            } else if (grid[i][j] === 3) {
                end = [i, j];
            }
        }
    }

    const queue = [[start[0], start[1], 0]];
    const visited = new Set([`${start[0]},${start[1]}`]);

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    while (queue.length > 0) {
        const [x, y, time] = queue.shift();

        if (x === end[0] && y === end[1]) {
            return time <= t;
        }

        if (time >= t) continue;

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;

            if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited.has(`${nx},${ny}`) && grid[nx][ny] !== 1) {
                visited.add(`${nx},${ny}`);
                queue.push([nx, ny, time + 1]);
            }
        }
    }

    return false;
}