function findDiagonalOrder(matrix) {
    if (matrix.length === 0 || matrix[0].length === 0) return [];

    const result = [];
    const rows = matrix.length;
    const cols = matrix[0].length;
    let row = 0, col = 0;
    let direction = 1; // 1 for up, -1 for down

    while (row < rows && col < cols) {
        result.push(matrix[row][col]);

        if (direction === 1) {
            if (row === 0 && col === cols - 1) {
                row++;
                direction = -1;
            } else if (row === 0) {
                col++;
                direction = -1;
            } else if (col === cols - 1) {
                row++;
                direction = -1;
            } else {
                row--;
                col++;
            }
        } else {
            if (row === rows - 1 && col === 0) {
                col++;
                direction = 1;
            } else if (col === 0) {
                row++;
                direction = 1;
            } else if (row === rows - 1) {
                col++;
                direction = 1;
            } else {
                row++;
                col--;
            }
        }
    }

    return result;
}