function findMaximumLength(nums) {
    const n = nums.length;
    const dp = new Array(n).fill(1);
    const last = new Array(1001).fill(-1);

    for (let i = 0; i < n; i++) {
        const num = nums[i];
        if (last[num] !== -1) {
            dp[i] = dp[last[num]] + 1;
        }
        last[num] = i;
    }

    return Math.max(...dp);
}