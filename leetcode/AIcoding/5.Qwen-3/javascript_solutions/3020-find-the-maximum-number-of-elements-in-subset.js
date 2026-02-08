function maximumLength(nums) {
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    let maxCount = 0;
    for (const [num, count] of freq.entries()) {
        let current = count;
        let next = num + 1;
        while (freq.has(next)) {
            current += freq.get(next);
            next++;
        }
        maxCount = Math.max(maxCount, current);
    }

    return maxCount;
}