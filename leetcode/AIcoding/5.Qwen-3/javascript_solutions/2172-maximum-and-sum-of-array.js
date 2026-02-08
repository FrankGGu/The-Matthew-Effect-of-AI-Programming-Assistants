function maxAndSum(nums) {
    const n = nums.length;
    const dp = new Array(1 << n).fill(0);
    const bits = new Array(1 << n).fill(0);

    for (let mask = 0; mask < (1 << n); mask++) {
        let count = 0;
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                count++;
            }
        }
        bits[mask] = count;
    }

    for (let mask = 1; mask < (1 << n); mask++) {
        let maxVal = 0;
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) {
                let prevMask = mask ^ (1 << i);
                maxVal = Math.max(maxVal, dp[prevMask] + (nums[i] & nums[bits[prevMask] - 1]));
            }
        }
        dp[mask] = maxVal;
    }

    return dp[(1 << n) - 1];
}