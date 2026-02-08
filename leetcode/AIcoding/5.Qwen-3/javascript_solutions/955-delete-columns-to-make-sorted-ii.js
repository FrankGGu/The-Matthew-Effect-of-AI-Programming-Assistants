function minDeletionSize(strs) {
    const n = strs.length;
    const m = strs[0].length;
    let count = 0;

    for (let j = 0; j < m; j++) {
        for (let i = 0; i < n - 1; i++) {
            if (strs[i][j] > strs[i + 1][j]) {
                count++;
                break;
            }
        }
    }

    return count;
}