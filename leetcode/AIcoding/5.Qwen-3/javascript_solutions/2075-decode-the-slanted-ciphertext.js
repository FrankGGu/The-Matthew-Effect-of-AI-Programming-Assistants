function decodeCiphertext(s, numRows) {
    if (numRows === 1 || numRows >= s.length) return s;

    const rows = Array.from({ length: numRows }, () => []);
    let row = 0;
    let direction = 1;

    for (let i = 0; i < s.length; i++) {
        rows[row].push(s[i]);
        row += direction;

        if (row === numRows - 1 || row === 0) {
            direction *= -1;
        }
    }

    let result = '';
    for (let r = 0; r < numRows; r++) {
        for (let c = 0; c < rows[r].length; c++) {
            result += rows[r][c];
        }
    }

    return result;
}