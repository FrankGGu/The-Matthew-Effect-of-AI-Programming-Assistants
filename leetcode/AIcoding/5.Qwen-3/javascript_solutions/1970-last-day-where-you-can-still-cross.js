function latestDayToCross(row, col, cells) {
    let left = 0, right = cells.length;
    const grid = new Array(row).fill(0).map(() => new Array(col).fill(0));

    const dfs = (i, j, visited) => {
        if (i < 0 || i >= row || j < 0 || j >= col || grid[i][j] === 1 || visited.has(`${i},${j}`)) return false;
        visited.add(`${i},${j}`);
        if (i === 0) return true;
        const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
        for (const [dx, dy] of directions) {
            if (dfs(i + dx, j + dy, visited)) return true;
        }
        return false;
    };

    while (left < right) {
        const mid = Math.ceil((left + right) / 2);
        for (let i = 0; i < mid; i++) {
            const [x, y] = cells[i];
            grid[x - 1][y - 1] = 1;
        }
        let found = false;
        const visited = new Set();
        for (let j = 0; j < col; j++) {
            if (grid[0][j] === 0 && dfs(0, j, visited)) {
                found = true;
                break;
            }
        }
        if (found) {
            left = mid;
        } else {
            right = mid - 1;
        }
        for (let i = 0; i < mid; i++) {
            const [x, y] = cells[i];
            grid[x - 1][y - 1] = 0;
        }
    }
    return left;
}