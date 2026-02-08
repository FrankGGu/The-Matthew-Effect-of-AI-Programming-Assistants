function shortestPathAllNodes(grid) {
    const n = grid.length;
    const m = grid[0].length;
    const target = (1 << n) - 1;
    const queue = [];
    const visited = new Set();

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (grid[i][j] === 0) {
                const state = (1 << i) | (1 << j);
                queue.push([i, j, state]);
                visited.add(`${i},${j},${state}`);
            }
        }
    }

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    while (queue.length > 0) {
        const [x, y, state] = queue.shift();
        const steps = queue[0] ? queue[0][2] : 0;

        if (state === target) return steps;

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < n && ny >= 0 && ny < m && grid[nx][ny] !== 1) {
                const next_state = state | (1 << nx) | (1 << ny);
                const key = `${nx},${ny},${next_state}`;
                if (!visited.has(key)) {
                    visited.add(key);
                    queue.push([nx, ny, next_state]);
                }
            }
        }
    }

    return -1;
}