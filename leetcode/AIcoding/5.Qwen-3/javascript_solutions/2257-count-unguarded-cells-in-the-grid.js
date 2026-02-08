function countUnguarded(n, m, guards, walls) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const grid = Array.from({ length: n }, () => Array(m).fill(0));

    for (const [x, y] of guards) {
        grid[x][y] = 2;
    }

    for (const [x, y] of walls) {
        grid[x][y] = 3;
    }

    const visited = Array.from({ length: n }, () => Array(m).fill(false));

    for (const [x, y] of guards) {
        for (const [dx, dy] of directions) {
            let nx = x + dx;
            let ny = y + dy;
            while (nx >= 0 && nx < n && ny >= 0 && ny < m && grid[nx][ny] !== 3) {
                if (!visited[nx][ny]) {
                    visited[nx][ny] = true;
                }
                nx += dx;
                ny += dy;
            }
        }
    }

    let count = 0;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            if (grid[i][j] === 0 && !visited[i][j]) {
                count++;
            }
        }
    }

    return count;
}