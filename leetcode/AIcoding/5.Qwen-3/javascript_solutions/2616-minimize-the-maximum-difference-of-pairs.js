function minimizeMax(nums, p) {
    nums.sort((a, b) => a - b);

    const n = nums.length;
    const dp = new Array(n).fill(0);

    for (let i = 1; i < n; i++) {
        dp[i] = dp[i - 1];
        if (i >= 1) {
            dp[i] = Math.min(dp[i], dp[i - 2] + nums[i] - nums[i - 1]);
        }
    }

    return dp[n - 1];
}