function imageSmoother(img) {
    const rows = img.length;
    const cols = img[0].length;
    const result = new Array(rows).fill(0).map(() => new Array(cols).fill(0));

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            let sum = 0;
            let count = 0;

            for (let x = i - 1; x <= i + 1; x++) {
                for (let y = j - 1; y <= j + 1; y++) {
                    if (x >= 0 && x < rows && y >= 0 && y < cols) {
                        sum += img[x][y];
                        count++;
                    }
                }
            }

            result[i][j] = Math.floor(sum / count);
        }
    }

    return result;
}