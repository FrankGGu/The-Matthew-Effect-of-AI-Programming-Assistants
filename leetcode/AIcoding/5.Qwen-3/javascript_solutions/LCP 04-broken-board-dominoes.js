function minDominoRotations(row, col) {
    function check(c) {
        let rotate = 0;
        for (let i = 0; i < row.length; i++) {
            if (row[i] === c) continue;
            if (col[i] === c) rotate++;
            else return -1;
        }
        return rotate;
    }

    let res = check(row[0]);
    if (res !== -1) return res;
    res = check(col[0]);
    if (res !== -1) return res;
    return -1;
}