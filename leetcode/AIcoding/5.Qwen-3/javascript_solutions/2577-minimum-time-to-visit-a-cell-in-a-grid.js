function minimumTime(grid, maxTime) {
    const rows = grid.length;
    const cols = grid[0].length;

    if (grid[0][0] > maxTime) return -1;

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const visited = Array.from({ length: rows }, () => Array(cols).fill(false));
    const pq = [];

    pq.push([0, 0, 0]);

    while (pq.length > 0) {
        pq.sort((a, b) => a[2] - b[2]);
        const [r, c, time] = pq.shift();

        if (visited[r][c]) continue;
        visited[r][c] = true;

        if (r === rows - 1 && c === cols - 1) return time;

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc]) {
                const newTime = time + grid[nr][nc];
                if (newTime <= maxTime) {
                    pq.push([nr, nc, newTime]);
                }
            }
        }
    }

    return -1;
}