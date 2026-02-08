function findNumberInDiagonal(n, k) {
    let row = 0;
    let col = 0;
    while (row + col < k - 1) {
        if (row === 0) {
            col++;
        } else if (col === 0) {
            row++;
        } else {
            row--;
            col++;
        }
    }
    return row + 1;
}