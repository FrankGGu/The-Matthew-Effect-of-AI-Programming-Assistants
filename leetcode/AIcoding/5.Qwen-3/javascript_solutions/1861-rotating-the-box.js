function rotateTheBox(box) {
    const m = box.length;
    const n = box[0].length;
    const result = new Array(n).fill(0).map(() => new Array(m).fill(' '));

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            result[j][m - 1 - i] = box[i][j];
        }
    }

    return result;
}