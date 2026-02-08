function firstCompleteVec(arr, mat) {
    const rows = mat.length;
    const cols = mat[0].length;
    const rowCounts = new Array(rows).fill(0);
    const colCounts = new Array(cols).fill(0);
    const valueToPos = {};

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            valueToPos[mat[i][j]] = [i, j];
        }
    }

    for (let i = 0; i < arr.length; i++) {
        const val = arr[i];
        const [row, col] = valueToPos[val];
        rowCounts[row]++;
        colCounts[col]++;
        if (rowCounts[row] === cols || colCounts[col] === rows) {
            return i;
        }
    }

    return -1;
}