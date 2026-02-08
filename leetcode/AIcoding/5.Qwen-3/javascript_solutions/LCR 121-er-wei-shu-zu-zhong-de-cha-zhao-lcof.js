function searchMatrix(matrix, target) {
    if (matrix.length === 0 || matrix[0].length === 0) return false;
    let rows = matrix.length;
    let cols = matrix[0].length;
    let left = 0;
    let right = rows * cols - 1;
    while (left <= right) {
        let mid = Math.floor((left + right) / 2);
        let current = matrix[Math.floor(mid / cols)][mid % cols];
        if (current === target) {
            return true;
        } else if (current < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return false;
}