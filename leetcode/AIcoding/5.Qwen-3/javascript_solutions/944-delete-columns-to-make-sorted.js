var minDeletionSize = function(strs) {
    let count = 0;
    for (let j = 0; j < strs[0].length; j++) {
        for (let i = 0; i < strs.length - 1; i++) {
            if (strs[i][j] > strs[i + 1][j]) {
                count++;
                break;
            }
        }
    }
    return count;
};