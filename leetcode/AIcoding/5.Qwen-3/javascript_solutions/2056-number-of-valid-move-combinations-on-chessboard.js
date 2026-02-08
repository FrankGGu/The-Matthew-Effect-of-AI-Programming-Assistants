function chessboardGame() {
    const moves = [[1, 2], [2, 1], [-1, 2], [-2, 1], [-1, -2], [-2, -1], [1, -2], [2, -1]];
    let result = 0;
    const visited = new Set();

    function dfs(x, y, steps) {
        const key = `${x},${y},${steps}`;
        if (visited.has(key)) return;
        visited.add(key);
        if (steps === 0) {
            result++;
            return;
        }
        for (const [dx, dy] of moves) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < 8 && ny >= 0 && ny < 8) {
                dfs(nx, ny, steps - 1);
            }
        }
    }

    for (let i = 0; i < 8; i++) {
        for (let j = 0; j < 8; j++) {
            dfs(i, j, 2);
        }
    }

    return result;
}