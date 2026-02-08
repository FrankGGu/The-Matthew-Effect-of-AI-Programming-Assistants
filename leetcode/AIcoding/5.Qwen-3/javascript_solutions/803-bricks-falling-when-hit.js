function hitBricks(bricks, hits) {
    const m = bricks.length;
    const n = bricks[0].length;
    const dirs = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function dfs(i, j, visited) {
        let count = 1;
        for (const [dx, dy] of dirs) {
            const x = i + dx;
            const y = j + dy;
            if (x >= 0 && x < m && y >= 0 && y < n && !visited[x][y] && bricks[x][y] === 1) {
                visited[x][y] = true;
                count += dfs(x, y, visited);
            }
        }
        return count;
    }

    function isStable(i, j) {
        if (i === 0) return true;
        for (const [dx, dy] of dirs) {
            const x = i + dx;
            const y = j + dy;
            if (x >= 0 && x < m && y >= 0 && y < n && bricks[x][y] === 1) {
                return true;
            }
        }
        return false;
    }

    const result = [];
    const visited = Array.from({ length: m }, () => Array(n).fill(false));

    for (const [x, y] of hits) {
        if (bricks[x][y] === 0) {
            result.push(0);
            continue;
        }
        bricks[x][y] = 0;
        let count = 0;
        for (const [dx, dy] of dirs) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && bricks[nx][ny] === 1) {
                if (!visited[nx][ny]) {
                    visited[nx][ny] = true;
                    count += dfs(nx, ny, visited);
                }
            }
        }
        result.push(count);
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                visited[i][j] = false;
            }
        }
    }

    return result;
}