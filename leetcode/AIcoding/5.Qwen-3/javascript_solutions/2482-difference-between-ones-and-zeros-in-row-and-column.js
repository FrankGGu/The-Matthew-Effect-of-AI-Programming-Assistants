function onesMinusZeros(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const rowOnes = new Array(m).fill(0);
    const colOnes = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            rowOnes[i] += grid[i][j];
            colOnes[j] += grid[i][j];
        }
    }

    const result = new Array(m).fill(0).map(() => new Array(n).fill(0));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            const ones = rowOnes[i] + colOnes[j];
            const zeros = (n - rowOnes[i]) + (m - colOnes[j]);
            result[i][j] = ones - zeros;
        }
    }

    return result;
}