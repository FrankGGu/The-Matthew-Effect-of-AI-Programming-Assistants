function areMatricesEqual(matrixA, matrixB) {
    for (let i = 0; i < matrixA.length; i++) {
        for (let j = 0; j < matrixA[0].length; j++) {
            if (matrixA[i][j] !== matrixB[i][j]) {
                return false;
            }
        }
    }
    return true;
}

function getShiftedMatrix(matrix, shift) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    const shifted = [];
    for (let i = 0; i < rows; i++) {
        shifted[i] = [];
        for (let j = 0; j < cols; j++) {
            shifted[i][j] = matrix[i][(j - shift + cols) % cols];
        }
    }
    return shifted;
}

function areSimilarAfterCyclicShifts(matrix) {
    const rows = matrix.length;
    const cols = matrix[0].length;
    const original = JSON.parse(JSON.stringify(matrix));
    for (let shift = 1; shift < cols; shift++) {
        const shifted = getShiftedMatrix(matrix, shift);
        if (areMatricesEqual(original, shifted)) {
            return true;
        }
    }
    return false;
}