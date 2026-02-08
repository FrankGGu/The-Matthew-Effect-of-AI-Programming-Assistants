function rowWithMaximumOnes(matrix) {
    let maxRow = 0;
    let maxCount = 0;

    for (let i = 0; i < matrix.length; i++) {
        let count = 0;
        for (let j = 0; j < matrix[i].length; j++) {
            if (matrix[i][j] === 1) {
                count++;
            }
        }
        if (count > maxCount) {
            maxCount = count;
            maxRow = i;
        }
    }

    return maxRow;
}