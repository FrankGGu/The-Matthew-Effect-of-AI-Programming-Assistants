function maximumRowsCovered(matrix, cols) {
    const rows = matrix.length;
    const colsCount = cols.length;
    const rowSet = new Set();

    for (let i = 0; i < colsCount; i++) {
        const col = cols[i];
        for (let r = 0; r < rows; r++) {
            if (matrix[r][col] === 1) {
                rowSet.add(r);
            }
        }
    }

    return rowSet.size;
}