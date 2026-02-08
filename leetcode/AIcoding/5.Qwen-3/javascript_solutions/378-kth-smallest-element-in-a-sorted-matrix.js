function kthSmallest(matrix, k) {
    let left = matrix[0][0];
    let right = matrix[matrix.length - 1][matrix[0].length - 1];

    while (left < right) {
        const mid = left + Math.floor((right - left) / 2);
        let count = 0;

        for (let i = 0; i < matrix.length; i++) {
            let j = 0;
            while (j < matrix[i].length && matrix[i][j] <= mid) {
                j++;
            }
            count += j;
        }

        if (count < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    return left;
}