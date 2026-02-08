var NumMatrix = function(matrix) {
    this.dp = [];
    for (let i = 0; i < matrix.length; i++) {
        this.dp[i] = [];
        for (let j = 0; j < matrix[0].length; j++) {
            this.dp[i][j] = matrix[i][j];
            if (i > 0) this.dp[i][j] += this.dp[i - 1][j];
            if (j > 0) this.dp[i][j] += this.dp[i][j - 1];
            if (i > 0 && j > 0) this.dp[i][j] -= this.dp[i - 1][j - 1];
        }
    }
};

NumMatrix.prototype.sumRegion = function(rect) {
    let [row1, col1, row2, col2] = rect;
    let sum = this.dp[row2][col2];
    if (row1 > 0) sum -= this.dp[row1 - 1][col2];
    if (col1 > 0) sum -= this.dp[row2][col1 - 1];
    if (row1 > 0 && col1 > 0) sum += this.dp[row1 - 1][col1 - 1];
    return sum;
};