function solveSudoku(board) {
    const n = 9;

    function isValid(row, col, num) {
        for (let i = 0; i < n; i++) {
            if (board[row][i] === num) return false;
            if (board[i][col] === num) return false;
            if (board[3 * Math.floor(row / 3) + Math.floor(i / 3)][3 * Math.floor(col / 3) + i % 3] === num) return false;
        }
        return true;
    }

    function backtrack() {
        for (let row = 0; row < n; row++) {
            for (let col = 0; col < n; col++) {
                if (board[row][col] === '.') {
                    for (let num = 1; num <= 9; num++) {
                        if (isValid(row, col, num.toString())) {
                            board[row][col] = num.toString();
                            if (backtrack()) return true;
                            board[row][col] = '.';
                        }
                    }
                    return false;
                }
            }
        }
        return true;
    }

    backtrack();
}