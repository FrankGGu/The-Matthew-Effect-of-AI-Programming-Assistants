var shortestPathLength = function(grid) {
    const n = grid.length;
    const m = grid[0].length;
    const keyCount = {};
    let keys = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            const c = grid[i][j];
            if (c >= 'a' && c <= 'f') {
                keyCount[c] = 1;
                keys++;
            }
        }
    }

    const target = (1 << keys) - 1;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const queue = [];
    const visited = new Set();

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (grid[i][j] === '@') {
                queue.push([i, j, 0]);
                visited.add(`${i},${j},0`);
            }
        }
    }

    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;

        for (let k = 0; k < size; k++) {
            const [x, y, mask] = queue.shift();

            if (mask === target) return steps;

            for (const [dx, dy] of directions) {
                const nx = x + dx;
                const ny = y + dy;

                if (nx >= 0 && nx < n && ny >= 0 && ny < m) {
                    const c = grid[nx][ny];

                    if (c === '#') continue;

                    if (c >= 'A' && c <= 'F') {
                        const key = c.toLowerCase();
                        if ((mask & (1 << keyCount[key])) === 0) continue;
                    }

                    let newMask = mask;

                    if (c >= 'a' && c <= 'f') {
                        newMask |= (1 << keyCount[c]);
                    }

                    const state = `${nx},${ny},${newMask}`;

                    if (!visited.has(state)) {
                        visited.add(state);
                        queue.push([nx, ny, newMask]);
                    }
                }
            }
        }

        steps++;
    }

    return -1;
};