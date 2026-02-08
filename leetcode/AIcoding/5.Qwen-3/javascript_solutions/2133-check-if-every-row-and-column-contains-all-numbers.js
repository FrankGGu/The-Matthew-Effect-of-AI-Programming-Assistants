function checkIfEveryRowAndColumnContainsAllNumbers(matrix) {
    const n = matrix.length;
    const expected = new Set([1, 2, 3, 4, 5, 6, 7, 8, 9]);

    for (let i = 0; i < n; i++) {
        const rowSet = new Set(matrix[i]);
        if (rowSet.size !== 9 || !Array.from(expected).every(num => rowSet.has(num))) {
            return false;
        }

        const colSet = new Set();
        for (let j = 0; j < n; j++) {
            colSet.add(matrix[j][i]);
        }
        if (colSet.size !== 9 || !Array.from(expected).every(num => colSet.has(num))) {
            return false;
        }
    }

    return true;
}