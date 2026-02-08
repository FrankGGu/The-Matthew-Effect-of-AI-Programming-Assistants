function findPort(matrix) {
    const n = matrix.length;
    for (let i = 0; i < n; i++) {
        let hasEdge = false;
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === 1) {
                hasEdge = true;
                break;
            }
        }
        if (!hasEdge) {
            for (let j = 0; j < n; j++) {
                if (i !== j && matrix[j][i] === 0) {
                    return -1;
                }
            }
            return i;
        }
    }
    return -1;
}