function minOperations(sand) {
    const rows = sand.length;
    const cols = sand[0].length;
    let operations = 0;

    for (let i = 0; i < rows - 1; i++) {
        for (let j = 0; j < cols; j++) {
            if (sand[i][j] === 1) {
                operations++;
                sand[i + 1][j] ^= 1;
            }
        }
    }

    return operations;
}