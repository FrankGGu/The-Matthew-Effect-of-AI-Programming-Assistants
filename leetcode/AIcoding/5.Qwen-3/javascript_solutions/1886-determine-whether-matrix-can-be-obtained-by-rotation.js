function findRotation(mat, target) {
    function rotateMatrix(matrix) {
        const n = matrix.length;
        const rotated = new Array(n).fill(0).map(() => new Array(n).fill(0));
        for (let i = 0; i < n; i++) {
            for (let j = 0; j < n; j++) {
                rotated[j][n - 1 - i] = matrix[i][j];
            }
        }
        return rotated;
    }

    function matricesEqual(a, b) {
        for (let i = 0; i < a.length; i++) {
            for (let j = 0; j < a[0].length; j++) {
                if (a[i][j] !== b[i][j]) return false;
            }
        }
        return true;
    }

    let current = mat;
    for (let i = 0; i < 4; i++) {
        if (matricesEqual(current, target)) return true;
        current = rotateMatrix(current);
    }
    return false;
}