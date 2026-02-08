function updateBoard(board, click) {
    const [row, col] = click;
    if (board[row][col] === 'M') {
        board[row][col] = 'X';
        return board;
    }
    dfs(row, col, board);
    return board;

    function dfs(r, c, board) {
        if (r < 0 || r >= board.length || c < 0 || c >= board[0].length || board[r][c] !== 'E') {
            return;
        }
        let count = 0;
        for (let i = -1; i <= 1; i++) {
            for (let j = -1; j <= 1; j++) {
                if (i === 0 && j === 0) continue;
                const nr = r + i;
                const nc = c + j;
                if (nr >= 0 && nr < board.length && nc >= 0 && nc < board[0].length && board[nr][nc] === 'M') {
                    count++;
                }
            }
        }
        if (count > 0) {
            board[r][c] = count.toString();
            return;
        }
        board[r][c] = 'B';
        for (let i = -1; i <= 1; i++) {
            for (let j = -1; j <= 1; j++) {
                if (i === 0 && j === 0) continue;
                dfs(r + i, c + j, board);
            }
        }
    }
}