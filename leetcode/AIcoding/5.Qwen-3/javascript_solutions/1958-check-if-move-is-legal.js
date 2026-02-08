function isLegalMove(board, rMove, cMove, color) {
    const directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];
    const n = board.length;
    if (board[rMove][cMove] !== ' ') return false;
    for (const [dr, dc] of directions) {
        let r = rMove + dr;
        let c = cMove + dc;
        let foundOpponent = false;
        while (r >= 0 && r < n && c >= 0 && c < n) {
            if (board[r][c] === ' ') break;
            if (board[r][c] === color) {
                if (foundOpponent) return true;
                else break;
            }
            foundOpponent = true;
            r += dr;
            c += dc;
        }
    }
    return false;
}