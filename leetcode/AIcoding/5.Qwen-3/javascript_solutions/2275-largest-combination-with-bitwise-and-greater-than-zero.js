var largestCombination = function(candidates) {
    let maxCount = 0;
    for (let i = 0; i < 32; i++) {
        let count = 0;
        for (const num of candidates) {
            if ((num >> i) & 1) {
                count++;
            }
        }
        maxCount = Math.max(maxCount, count);
    }
    return maxCount;
};