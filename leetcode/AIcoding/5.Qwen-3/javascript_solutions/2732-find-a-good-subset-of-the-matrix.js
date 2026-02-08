function findGoodSubset(matrix) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    const result = [];

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (matrix[i][j] === 1) {
                result.push([i, j]);
                return result;
            }
        }
    }

    return result;
}