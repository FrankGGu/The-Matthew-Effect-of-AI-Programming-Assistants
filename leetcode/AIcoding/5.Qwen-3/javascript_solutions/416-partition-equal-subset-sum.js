function canPartition(nums) {
    const sum = nums.reduce((a, b) => a + b, 0);
    if (sum % 2 !== 0) return false;
    const target = sum / 2;
    const dp = new Set([0]);
    for (const num of nums) {
        for (const s of dp) {
            if (s + num === target) return true;
            if (s + num < target) dp.add(s + num);
        }
    }
    return false;
}