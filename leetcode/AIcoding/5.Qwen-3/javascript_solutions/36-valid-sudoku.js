function isValidSudoku(board) {
    const rows = Array(9).fill().map(() => new Set());
    const cols = Array(9).fill().map(() => new Set());
    const boxes = Array(9).fill().map(() => new Set());

    for (let row = 0; row < 9; row++) {
        for (let col = 0; col < 9; col++) {
            const num = board[row][col];
            if (num === '.') continue;
            const boxIndex = Math.floor(row / 3) * 3 + Math.floor(col / 3);
            if (rows[row].has(num) || cols[col].has(num) || boxes[boxIndex].has(num)) {
                return false;
            }
            rows[row].add(num);
            cols[col].add(num);
            boxes[boxIndex].add(num);
        }
    }
    return true;
}