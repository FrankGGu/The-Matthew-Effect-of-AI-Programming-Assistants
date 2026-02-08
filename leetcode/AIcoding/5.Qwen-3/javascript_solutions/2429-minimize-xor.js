function minimizeXor(nums, target) {
    const n = nums.length;
    const dp = new Array(n).fill(0).map(() => new Array(target + 1).fill(0));

    for (let i = 0; i < n; i++) {
        dp[i][0] = Math.abs(nums[i] - 0);
    }

    for (let i = 0; i < n; i++) {
        for (let j = 1; j <= target; j++) {
            if (i === 0) {
                dp[i][j] = Math.abs(nums[i] - j);
            } else {
                dp[i][j] = Math.min(dp[i - 1][j - nums[i]] + Math.abs(nums[i] - j), dp[i - 1][j] + Math.abs(nums[i] - j));
            }
        }
    }

    return dp[n - 1][target];
}