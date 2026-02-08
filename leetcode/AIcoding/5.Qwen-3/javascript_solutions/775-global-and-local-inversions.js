function isIdealMatrix(matrix) {
    for (let i = 0; i < matrix.length; i++) {
        if (Math.abs(matrix[i] - i) > 1) {
            return false;
        }
    }
    return true;
}