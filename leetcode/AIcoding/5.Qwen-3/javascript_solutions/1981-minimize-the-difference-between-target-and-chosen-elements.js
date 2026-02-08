function minimizeDifference(nums, x) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    let minDiff = Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const target = Math.floor((nums[i] + nums[j]) / 2);
            const diff = Math.abs(target - x);
            if (diff < minDiff) {
                minDiff = diff;
            }
        }
    }

    return minDiff;
}