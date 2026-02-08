function maximumSafenessFactor(grid) {
    const n = grid.length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function getDistanceMatrix() {
        const dist = Array(n).fill().map(() => Array(n).fill(0));
        const queue = [];

        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                if (grid[i][j] === 1) {
                    queue.push([i, j]);
                }
            }
        }

        let step = 0;
        while (queue.length > 0) {
            const size = queue.length;
            for (let k = 0; k < size; k++) {
                const [x, y] = queue.shift();
                dist[x][y] = step;
                for (const [dx, dy] of directions) {
                    const nx = x + dx;
                    const ny = y + dy;
                    if (nx >= 0 && ny >= 0 && nx < n && ny < n && dist[nx][ny] === 0) {
                        dist[nx][ny] = step + 1;
                        queue.push([nx, ny]);
                    }
                }
            }
            step++;
        }

        return dist;
    }

    const dist = getDistanceMatrix();

    function canReach(k) {
        const visited = Array(n).fill().map(() => Array(n).fill(false));
        const queue = [[0, 0]];
        visited[0][0] = true;

        while (queue.length > 0) {
            const size = queue.length;
            for (let k2 = 0; k2 < size; k2++) {
                const [x, y] = queue.shift();
                if (x === n - 1 && y === n - 1) return true;
                for (const [dx, dy] of directions) {
                    const nx = x + dx;
                    const ny = y + dy;
                    if (nx >= 0 && ny >= 0 && nx < n && ny < n && !visited[nx][ny] && dist[nx][ny] >= k) {
                        visited[nx][ny] = true;
                        queue.push([nx, ny]);
                    }
                }
            }
        }

        return false;
    }

    let left = 0, right = Math.min(n, n);
    let result = 0;

    while (left <= right) {
        const mid = Math.floor((left + right) / 2);
        if (canReach(mid)) {
            result = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return result;
}