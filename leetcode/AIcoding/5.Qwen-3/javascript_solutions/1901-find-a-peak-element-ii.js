function findPeak(matrix) {
    let rows = matrix.length;
    let cols = matrix[0].length;
    let left = 0;
    let right = cols - 1;

    while (left <= right) {
        let midCol = Math.floor((left + right) / 2);
        let maxRow = 0;
        for (let i = 1; i < rows; i++) {
            if (matrix[i][midCol] > matrix[maxRow][midCol]) {
                maxRow = i;
            }
        }

        if (midCol > 0 && matrix[maxRow][midCol] < matrix[maxRow][midCol - 1]) {
            right = midCol - 1;
        } else if (midCol < cols - 1 && matrix[maxRow][midCol] < matrix[maxRow][midCol + 1]) {
            left = midCol + 1;
        } else {
            return [maxRow, midCol];
        }
    }

    return [-1, -1];
}