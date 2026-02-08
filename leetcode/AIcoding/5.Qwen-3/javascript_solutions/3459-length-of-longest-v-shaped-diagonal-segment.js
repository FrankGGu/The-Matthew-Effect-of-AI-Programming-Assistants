function longestVShapeDiagonal(matrix) {
    if (matrix.length === 0 || matrix[0].length === 0) return 0;

    const rows = matrix.length;
    const cols = matrix[0].length;
    let maxLen = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            let len = 1;
            let x = i + 1;
            let y = j - 1;
            while (x < rows && y >= 0 && matrix[x][y] === matrix[i][j]) {
                len++;
                x++;
                y--;
            }
            x = i - 1;
            y = j + 1;
            while (x >= 0 && y < cols && matrix[x][y] === matrix[i][j]) {
                len++;
                x--;
                y++;
            }
            maxLen = Math.max(maxLen, len);
        }
    }

    return maxLen;
}