function guardCastle(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    function bfs(startRow, startCol) {
        const queue = [[startRow, startCol]];
        const visited = Array.from({ length: m }, () => Array(n).fill(false));
        visited[startRow][startCol] = true;

        while (queue.length > 0) {
            const [r, c] = queue.shift();
            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;
                if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc] && grid[nr][nc] === '0') {
                    visited[nr][nc] = true;
                    queue.push([nr, nc]);
                }
            }
        }

        let count = 0;
        for (let i = 0; i < m; i++) {
            for (let j = 0; j < n; j++) {
                if (visited[i][j]) {
                    count++;
                }
            }
        }
        return count;
    }

    let max = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === '0') {
                max = Math.max(max, bfs(i, j));
            }
        }
    }
    return max;
}