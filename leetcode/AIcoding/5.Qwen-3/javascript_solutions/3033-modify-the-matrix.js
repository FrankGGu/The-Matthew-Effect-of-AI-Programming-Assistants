function modifiedMatrix(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const rowMax = new Array(m).fill(0);
    const colMax = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            rowMax[i] = Math.max(rowMax[i], matrix[i][j]);
        }
    }

    for (let j = 0; j < n; j++) {
        for (let i = 0; i < m; i++) {
            colMax[j] = Math.max(colMax[j], matrix[i][j]);
        }
    }

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === rowMax[i]) {
                matrix[i][j] = colMax[j];
            }
        }
    }

    return matrix;
}