function largestOutlier(nums) {
    const freq = new Map();
    for (const num of nums) {
        freq.set(num, (freq.get(num) || 0) + 1);
    }

    let maxOutlier = -Infinity;

    for (const num of nums) {
        const count = freq.get(num);
        if (count > 1) {
            freq.set(num, count - 1);
            const sum = nums.reduce((acc, n) => acc + n, 0) - num;
            if (sum < num) {
                maxOutlier = Math.max(maxOutlier, num);
            }
            freq.set(num, count);
        } else {
            const sum = nums.reduce((acc, n) => acc + n, 0) - num;
            if (sum < num) {
                maxOutlier = Math.max(maxOutlier, num);
            }
        }
    }

    return maxOutlier;
}