function snakesAndLadders(board) {
    const n = board.length;
    const queue = [[1, 0]]; // [position, steps]
    const visited = new Set();
    visited.add(1);

    while (queue.length > 0) {
        const [pos, steps] = queue.shift();
        if (pos === n * n) return steps;

        for (let i = 1; i <= 6; i++) {
            const nextPos = pos + i;
            if (nextPos > n * n) break;

            let [row, col] = getCoordinates(nextPos, n);
            if (board[row][col] !== -1) {
                nextPos = board[row][col];
            }

            if (!visited.has(nextPos)) {
                visited.add(nextPos);
                queue.push([nextPos, steps + 1]);
            }
        }
    }

    return -1;
}

function getCoordinates(pos, n) {
    pos -= 1;
    const row = Math.floor(pos / n);
    const col = pos % n;
    if (row % 2 === 1) {
        return [n - 1 - row, n - 1 - col];
    } else {
        return [n - 1 - row, col];
    }
}